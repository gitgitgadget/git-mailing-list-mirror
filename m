From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v1] annotate: skip checking working tree if a revision is provided
Date: Fri, 20 Nov 2015 19:40:28 -0600
Message-ID: <CAOc6etYzxbY9SR7aegTdqo9RB8bcRoL9ihZZDP3rDZVUwDT6BA@mail.gmail.com>
References: <1447809609-17556-1-git-send-email-eantoranz@gmail.com>
	<CAOc6etbF-yF0bhmmjQG=P=FW0QnokPTXnqLiyPM7uJ7eqom9rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 21 02:40:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzxAH-00051D-AM
	for gcvg-git-2@plane.gmane.org; Sat, 21 Nov 2015 02:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759908AbbKUBk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 20:40:29 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33022 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbbKUBk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 20:40:28 -0500
Received: by pabfh17 with SMTP id fh17so136589528pab.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2015 17:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5L62ssa5iwEJUMxc7uwKi/S8s2oItupux2LH3ri1NcI=;
        b=ORmQwcNyj2wxpWUm04LBs/CmTRmlREtT09NX5L7UsauzSlg7Y1iGBlXtMeTFYTBcdc
         RX9R7rBtOk3tklZDu6K2JXQ6iIzCoNNjMp9BVmMa77mIYd2CcF6uHBYctsuqj2KHWiii
         XBRJEX/JASrTEHIpY2WEU8Vbu7UZvyJaJyyIbJGj6vbE+ca1SAc9F3YsGxmXEt2vqCky
         yXKmwaeXuF2Awqj4YNOhyvvLV14NWEgI9/V1GMn2jyVMROWmDlPipjvC65goXcuDH9oO
         X7YzgL3PtGw2zweJ5lm0TFAdAQEVLipzoCMnYQ0/cgeFM8RWYuLkAtufqmmylyT4OohU
         fiug==
X-Received: by 10.67.14.104 with SMTP id ff8mr1325123pad.92.1448070028444;
 Fri, 20 Nov 2015 17:40:28 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Fri, 20 Nov 2015 17:40:28 -0800 (PST)
In-Reply-To: <CAOc6etbF-yF0bhmmjQG=P=FW0QnokPTXnqLiyPM7uJ7eqom9rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281542>

And I did't say it right. The execution path where dashdash_pos is 0
is coming from "annotate". Sorry for my confusion on the previous
mail.

On Fri, Nov 20, 2015 at 7:25 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> On Tue, Nov 17, 2015 at 7:20 PM, Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
>> +       if (!revs.pending.nr && !file_exists(path))
>> +               die_errno("cannot stat path '%s'", path);
>> +
>
> I was wondering if I should only check the path that is coming from
> "blame" (which is where I'm taking the check from) by checking
> dashdash_pos:
>
> if (!dashdash_pos && !revs.pending.nr && !file_exists(path))
>     die_errno("cannot stat path '%s'", path);
>
> So that we don't apply the check if we are coming from normal
> dashdash_pos != 0 (and which didn't apply the filesystem check).
>
> Thanks in advance.
