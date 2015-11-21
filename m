From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v1] annotate: skip checking working tree if a revision is provided
Date: Fri, 20 Nov 2015 19:25:55 -0600
Message-ID: <CAOc6etbF-yF0bhmmjQG=P=FW0QnokPTXnqLiyPM7uJ7eqom9rw@mail.gmail.com>
References: <1447809609-17556-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 21 02:26:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzwwC-0001e2-LV
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 02:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761217AbbKUBZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 20:25:57 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35113 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760389AbbKUBZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 20:25:56 -0500
Received: by pacej9 with SMTP id ej9so132257737pac.2
        for <git@vger.kernel.org>; Fri, 20 Nov 2015 17:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0erqhtvCXRyGeAm+hGVnMmN4zhvO0sAEllVsBo4tE8I=;
        b=tdiKoJA6JfrvfqYECKzO2C+4cQehssu4qd32bf7KJM3JkLfnBuSLyPGLxnlcEx0lbF
         pvZv3R76WW5ZoEOFGZAB+JuHp3JAls8hBJgkOnxa8V72Vbh1sUhuYO3dgkpzum/rO9Cx
         do1RuwVMoNYlbO1fjZrHqsiFtzfYDjQSeT8lXRhrMlSvQYKqenHU5R48YypKV9IMjTdU
         qFlMQPAjIA9q4OAmi1UUekzeTeasgfs4g+Al4eMyfSer+KnfBQnbmtB3vuOH76Iw4ZPB
         nP/Q39S4XVD3VmNztEKz4wq+gCuEtm7FPRxALvNK2mqgXsdR1iOjJx1M8fpYnbDqXOCj
         4iag==
X-Received: by 10.98.75.83 with SMTP id y80mr2756962pfa.77.1448069155869; Fri,
 20 Nov 2015 17:25:55 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Fri, 20 Nov 2015 17:25:55 -0800 (PST)
In-Reply-To: <1447809609-17556-1-git-send-email-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281541>

On Tue, Nov 17, 2015 at 7:20 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> +       if (!revs.pending.nr && !file_exists(path))
> +               die_errno("cannot stat path '%s'", path);
> +

I was wondering if I should only check the path that is coming from
"blame" (which is where I'm taking the check from) by checking
dashdash_pos:

if (!dashdash_pos && !revs.pending.nr && !file_exists(path))
    die_errno("cannot stat path '%s'", path);

So that we don't apply the check if we are coming from normal
dashdash_pos != 0 (and which didn't apply the filesystem check).

Thanks in advance.
