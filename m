From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 6/6] worktree: simplify prefixing paths
Date: Mon, 23 May 2016 00:31:08 -0400
Message-ID: <CAPig+cTYZORwm-Wc3JkzHaaasOxJytYiFVgayb21fWrvXnf_Bw@mail.gmail.com>
References: <20160510141416.GA22672@lanh>
	<20160522093356.22389-1-pclouds@gmail.com>
	<20160522093356.22389-7-pclouds@gmail.com>
	<CAPig+cSpoi0eMKQPqKG6+skc87dgDLZiLJZJLUk-iyd13P3E3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 06:36:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4hbU-0006QR-NB
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 06:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849AbcEWEg3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 May 2016 00:36:29 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:36843 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbcEWEg2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2016 00:36:28 -0400
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 May 2016 00:36:28 EDT
Received: by mail-it0-f43.google.com with SMTP id e62so23720299ita.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 21:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=kRLY0sVMK2ZbmYe+oew/B4d0bKD98KjxK4+hf/ol21M=;
        b=zfxFihuFQ9prI/iJkYwWoivWNqEUS8QTdXfB9GpcVfhAqGADdwyvO7lTPnjUv2Xwxq
         ea9TOamq7ETCqphPVifQaswrvzTaJFxUPgXRqW6wO5YHSam9xQ/TQpD+cex/l43dZNSf
         1aa82lQKvF45xzaJTxR9+DI8WDbL3oO4FPdVH/LQMNi3mSyXM5DnVLmBZP95oA3bsKDB
         aHKMBKBax7vqddSvMGERPoqxCk4+G9G6DkpkxlYuxna5jEftWIQoz31rhHo3y66cDsf4
         fgIQ4lq+OrV5tp6XGTuohqyKnaielG/2qwBr3X6F538ntk21PrTHWY+5ghltsi3L0Ibe
         /bJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=kRLY0sVMK2ZbmYe+oew/B4d0bKD98KjxK4+hf/ol21M=;
        b=GkCs1IryI1YtM6fMjLT/bGP5cTPGVGhjHg8cldpe67OFMRHv+7VEtlJeiKwB3sZs48
         cUnx7ef9zo6nuKAs0c4r793d12UusAVyArBhd3JBPyDdqJQpYD8sEEtOy1xvN0pK2M3M
         6ZOxHP9lQHvDMGlsBa32GD8fZy+jN4bzCo3WHAyUt2E3tmgWBcfeChSDh9rvuOFpTWcK
         v9+0i+Ol/VG1tOgtG4WQzzblKCRAXbspYXc35WGggvX4rmmM3b2/SOb8PCf7FSgrSP3j
         UqH9sOC3U9YKySXJyLsWh2X7Ugeerrw1Gab4Ku0pJak5lum5zMCGjHD2a4uVH6mv+fJ6
         ZujQ==
X-Gm-Message-State: AOPr4FVY4Xm9Pi2wePyDAwpVQ2me74NMiGCHHDMzKW9VHjGXNo8JCBoLHIA9wtbp5m6VnEIOA1wDa+IFbmK1pg==
X-Received: by 10.36.55.13 with SMTP id r13mr11298367itr.73.1463977868370;
 Sun, 22 May 2016 21:31:08 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Sun, 22 May 2016 21:31:08 -0700 (PDT)
In-Reply-To: <CAPig+cSpoi0eMKQPqKG6+skc87dgDLZiLJZJLUk-iyd13P3E3g@mail.gmail.com>
X-Google-Sender-Auth: lXkdSddv_izL6mqDyJAyX2OcoMM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295307>

On Sun, May 22, 2016 at 7:32 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Sun, May 22, 2016 at 5:33 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> @@ -467,6 +467,8 @@ int cmd_worktree(int ac, const char **av, const =
char *prefix)
>>         if (ac < 2)
>>                 usage_with_options(worktree_usage, options);
>> +       if (!prefix)
>> +               prefix =3D "";
>
> Considering that all the other existing git-worktree subcommands
> already handle NULL prefix acceptably, it makes me a bit uncomfortabl=
e
> that this "fix", which could be local to add(), leaks into all the
> other subcommands, thus making the assumption that they (or other new
> subcommands) will never care about the distinction between NULL and
> "".
>
> Not a big objection; just a minor niggle, probably not worth a re-rol=
l.

Okay, I see that you're taking advantage of the prefix=3D"" in patch
5/6, as well, so it's not benefitting only add().
