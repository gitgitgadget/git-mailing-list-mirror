From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Segfault in the attr stack
Date: Thu, 2 Jun 2016 08:02:48 +0700
Message-ID: <CACsJy8A4gXRyx4LpBmM2Y=n2KB0NurKMiW42-tPnU7K89qj5bw@mail.gmail.com>
References: <CAGZ79ka_4vZfNhgOyMeFKdossO-S5Q7RVnvEzB8YAJNc1YQ+uQ@mail.gmail.com>
 <CAGZ79kbSKgS42nAShsK3JV78geam3k84=ipWRx7vbRODuHcmcA@mail.gmail.com> <CAPc5daXuQAeWvJAciRA_Kzyoxa=atEntGzKhqzjiN+ho6TnQyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 03:03:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8H31-0007rb-Hn
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 03:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbcFBBDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 21:03:20 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:36422 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbcFBBDS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 21:03:18 -0400
Received: by mail-io0-f182.google.com with SMTP id k19so19806273ioi.3
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 18:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hY9UsjnJMmbMb+rUzOR5sIrqJmFChoyNI/VJ5bSksdo=;
        b=r+ovyr+yZHX+uDV1adwd7MSTv+ox4WjuyLX7FfreQiRjWZ0XbW37GBC/LItK9gpg01
         q0pqQEFhSn8IyfSH3tfKPAEsCiXGxuyNm3sfoKXUB2HE00IcPcCYjbRjXMWV/KDNX/B5
         SjkzV5UqNrNGWx+XLgngAWxujkzcVEq2igzMdAiqWYdhajoRvTYwlU1jiqXhJtkfKEq2
         q2QfB2BOX7GnH+pk9t6ggIYB2/bMBlHLAywXmyJfRgkSBJ8KTgyFgyAPJU5dp3Ywo3tr
         22YrA8z6l4m7jLOHY8bixH8EqHcDOpkr4vABZq+KPVLFgsWtKTA1jynpEkIUFUltd7DH
         McAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hY9UsjnJMmbMb+rUzOR5sIrqJmFChoyNI/VJ5bSksdo=;
        b=P/OEW3JYsdjYwIfBreGLjRcTSG+h2nnkwP1TcnPuFsqlJvf4dQu0FZKJBHMBnHmjLa
         WboVe8mUxXF26REFyYcJSCqr59TCQS4JjmNDgeRpDXXXoKWPilWHuNDDcnprSwEr3rCs
         qnR6cohW7ASmR86HN9zhY9Pl82hV8kEm9KPHVP4aK8tjTjjadtfd0MAR+ORBeMdm50t0
         hiiHyUAGXyKVpMLI88hNdKhsDPBtwoKLGnXRbu+kyQt8Lv14lF8LEBYHD71vwKfn8WTd
         IBgXf8vGqyHzmgg6iTLV2ONMk2zavRCpKBT6FQbBxjC2WmtEhl8rVP1k2xOnyE/QJkxY
         HpQw==
X-Gm-Message-State: ALyK8tJQdO/BM3uiVOa6US5xQ3fyflYswMewdtAsyez7k/8sp7Y/gf3YnnaotDfN3l8dqMjxiFhoIGdLh/siog==
X-Received: by 10.107.159.84 with SMTP id i81mr491671ioe.29.1464829397660;
 Wed, 01 Jun 2016 18:03:17 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Wed, 1 Jun 2016 18:02:48 -0700 (PDT)
In-Reply-To: <CAPc5daXuQAeWvJAciRA_Kzyoxa=atEntGzKhqzjiN+ho6TnQyg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296182>

On Thu, Jun 2, 2016 at 5:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Gaah, of course.
>
> This is coming from the cache preload codepath, where multiple threads
> try to run ce_path_match().
> It used to be OK because pathspec magic never looked at attributes,
> but now it does, and attribute system is not thread-safe.

Off topic. I wonder if we can annotate which functions are thread-safe
(minority currently in git code base, I believe) and make gcc, clang
or sparse spot them in threaded code?
-- 
Duy
