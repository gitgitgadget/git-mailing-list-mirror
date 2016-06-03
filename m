From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 2/6] worktree.c: find_worktree() learns to identify
 worktrees by basename
Date: Fri, 3 Jun 2016 18:11:29 +0700
Message-ID: <CACsJy8BF_KKXdMNW_aOs522wBbW9BQhbrZ_0hx+f2MCW-VPUzg@mail.gmail.com>
References: <20160522104341.656-1-pclouds@gmail.com> <20160530104939.28407-1-pclouds@gmail.com>
 <20160530104939.28407-3-pclouds@gmail.com> <xmqqh9de5d6e.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CmdTapWsst-PuwFNH8Uy3Vgow+fKWzQ+tGYPSc=aZsXg@mail.gmail.com>
 <xmqqr3cgycjl.fsf@gitster.mtv.corp.google.com> <CACsJy8B+j2im7XOV==tBtki=tOCN4k3ZHz6Jp4fq4qjqarb+ew@mail.gmail.com>
 <xmqqfusvv8lq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 13:12:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8n1N-0000NU-BP
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 13:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbcFCLMC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 07:12:02 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:35401 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbcFCLL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 07:11:59 -0400
Received: by mail-io0-f194.google.com with SMTP id k19so9815801ioi.2
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 04:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a9RdqzR26V5ZOtQ/i8UVCm43MUEcVrh62L2DuzPTG3U=;
        b=mSIAafQFELQ/Peb5jpNDZnLe9+Q32PgTxrAp2YmzbQ6JszpLZ3V8weeoAT88m37bPg
         VfJ1Ny8BBGprk410bKksJsbCUkll0qZEIJHYbjQZGw3Iahd8NIV+hnlU1qjAeDL/4vol
         ICXnfCQ1vx+i+wAno/+CoqQxy0Db9aD3JlGbWv6IxMiAU/9sG4RMrEHXZ8hRVtnVX3Rw
         LErkHvLaz+Mqcyrudb+DRb5s2A8zXcKhTOPIlIe/cMM3MpNFkwcHg1JkCJ//Zmk/sxDo
         3Cgl+JfJcBos5Ni1+FH8usmmZJWGrUrmUDl7F7mGdoPkIdeMvAnToYAHpDilCMt634wF
         4ooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a9RdqzR26V5ZOtQ/i8UVCm43MUEcVrh62L2DuzPTG3U=;
        b=Nl2wCheAfU3byBak7l97as1+mQskCfLrWFPad23kOFtFoTJHc2sVc4omWqDELqhW4c
         p5+2h+a1i/zWdP6vAVgsa+cJE0GmsZ7FANKwgImHcA9lMtPnEKr0msveDtKqHTU42lUQ
         QkWtBeuI5NRu+DEXc99Hpl7aZaq4wIhO6sI9yZQ8Hu4LZS/ZwaFU/PIb5s7bIhXzRrHw
         7h95V9aT/3M5UhJMuQcK9Ngg6wifkrLyV4Qi/ku9SJDZWxNpi5j5iMM1ur5nwIzEqDL0
         QwaRSjd6f01q2tW6nLiKeVXrdt4QblpAyj5XPgGp2ekABPXaIR1ST2K+C3L+Yz0l4+30
         aSmw==
X-Gm-Message-State: ALyK8tKCoZNw5xhVLVjFYzd4t7h0w4nAWmsgHomiqU0zQ9HveW9Bzait8in5zvhtDPkUJ2Eu7qZGN3hMA3clOw==
X-Received: by 10.107.159.84 with SMTP id i81mr3819769ioe.29.1464952318963;
 Fri, 03 Jun 2016 04:11:58 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Fri, 3 Jun 2016 04:11:29 -0700 (PDT)
In-Reply-To: <xmqqfusvv8lq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296301>

On Thu, Jun 2, 2016 at 11:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> +static struct worktree *find_worktree_by_basename(struct worktree **list,
> +                                                 const char *base_name)
> +{
> +       struct worktree *found = NULL;
> +       int nr_found = 0;
> +
> +       for (; *list && nr_found < 2; list++) {
> +               char *path = xstrdup((*list)->path);
> +               if (!fspathcmp(base_name, basename(path))) {
> +                       found = *list;
> +                       nr_found++;
> +               }
> +               free(path);
> +       }
> +       return nr_found == 1 ? found : NULL;
> +}
>
>
>> If we always split at '/' boundary though (e.g. "abc/def/ghi",
>> "def/ghi" or "ghi" but never "ef/ghi") then it should be ok.
>
> Does "basename()" used here know '/' and '\' can both be a directory
> separator, or does worktree->path have a normalized representation
> of the path, i.e. '/' is the only directory separator?

basename() does (or I think so because Windows has its own version).
worktree->path always uses '/' but the command line option can come
with either '/' or '\'. Probably safest to accept both.
-- 
Duy
