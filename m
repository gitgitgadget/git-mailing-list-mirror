From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 04/11] tests: introduce test_ln_s and test_ln_s_add
Date: Sat, 1 Jun 2013 16:41:35 +0530
Message-ID: <CALkWK0nN2V3Cwi3n+DV7Bcme7jE=B+COFioqPFfHQgxGTWEtiA@mail.gmail.com>
References: <cover.1370076477.git.j6t@kdbg.org> <c7be5891891d1eeba540a5a24f07d58514345b2b.1370076477.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jun 01 13:12:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UijjS-0005wv-EU
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 13:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab3FALMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 07:12:18 -0400
Received: from mail-bk0-f41.google.com ([209.85.214.41]:64811 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab3FALMR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 07:12:17 -0400
Received: by mail-bk0-f41.google.com with SMTP id jc10so1152387bkc.0
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 04:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FDlKUJsiGCL1stF3djG3sy58BfYp+tLYGgHgJ9Y+gTk=;
        b=jtmW58AGFhjxtxzYMpbGgnOmtE0krKyf7mvYsvT6H2AX6ZLTvuvjudlP1hEkzwjbjr
         2xFwwjeW2jlzEolDkkFPEMSbD1WplLyfIm5KWsdLTZa6Q1GGm2lr9FhhwptT/4JlezC8
         0yHhXDIrE2Diy+ITdLDoMhUErvrvfl7Skue/lRaRvLXKUnr/FBH44FPaWZ4u8VRDSsoi
         fNOZhYjz4NdscqvQqTZkkGC4IatFxfE04M6huKaTTBUeuIbEErR8sxXz9jJPrnP/ga7k
         W7k6P1ly2NsQBi4P7Xink9mjov34Km2nar+/vWa+FE0vbr0Y4GEiBAs5Qy5K2/X9BRLg
         8+CQ==
X-Received: by 10.205.115.5 with SMTP id fc5mr4354403bkc.155.1370085135519;
 Sat, 01 Jun 2013 04:12:15 -0700 (PDT)
Received: by 10.204.172.209 with HTTP; Sat, 1 Jun 2013 04:11:35 -0700 (PDT)
In-Reply-To: <c7be5891891d1eeba540a5a24f07d58514345b2b.1370076477.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226123>

Johannes Sixt wrote:
> +test_ln_s_add () {
> +       if test_have_prereq SYMLINKS
> +       then
> +               ln -s "$1" "$2" &&
> +               git update-index --add "$2"
> +       else
> +               printf '%s' "$1" >"$2" &&
> +               ln_s_obj=$(git hash-object -w "$2") &&
> +               git update-index --add --cacheinfo 120000 $ln_s_obj "$2"
> +       fi
> +}

Nicely done.  As far as git is concerned, a symlink is nothing but a
plain file containing the destination filename (minus the newline)
with mode 120000 in the index.

> +test_ln_s () {
> +       if test_have_prereq SYMLINKS
> +       then
> +               ln -s "$1" "$2"
> +       else
> +               printf '%s' "$1" >"$2"
> +       fi
> +}

What is this?  We can't test_ln_s something and then 'git add' it, so
what purpose does this serve?
