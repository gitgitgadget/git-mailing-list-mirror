From: Brandon Casey <drafnel@gmail.com>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 10:13:22 -0700
Message-ID: <CA+sFfMfzpYaqRc7A0sZykA8PZ3LKahYVi9XASwCRGCEQO5PrrA@mail.gmail.com>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
	<CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
	<004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
	<CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
	<01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>
	<7v628epzia.fsf@alter.siamese.dyndns.org>
	<000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>
	<7vy5l9lj6m.fsf@alter.siamese.dyndns.org>
	<001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de>
	<7v4nnxld24.fsf@alter.siamese.dyndns.org>
	<002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de>
	<CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	rsbecker@nexbridge.com
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:13:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4EUn-0007Rc-Tz
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830Ab2HVRNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:13:25 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:57482 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824Ab2HVRNX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:13:23 -0400
Received: by vcbfk26 with SMTP id fk26so1280738vcb.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kaXNhHwHxSfC2GNPqhTH6XQ1aS0na656udsnRSgJ9nM=;
        b=pedaKjYJl/3cgkc3PDa8zRbQ9d009q6EKqCtsU+sXVtXwvY1HnEdWkiackHeXBy56P
         oh7fYwYoNeATTB4kNTtjAXOUpIrajrYfSXleTQR5tRyG2hfsDk2wts8S2gRbYNAhuOKY
         naQdW0IJsU+R0nT+C+MZ0LQBaJJEYnuFSuAYxaQL2vY30X0dGbnGFIp3r6I0JYgipfCW
         t/Zxwm6/qHYvmMIjSm/EocqFzD3bwhoQQ91e/GWdvLzB5QkHyYklujBN8NtZYqUO6+ek
         +dZj/vnmw7Y6Lg6Fqzh/0xmjjgASRE4OohNlUX5Rd8eOkFgw36eGqZs6AbTwdbmjjDIV
         MwqA==
Received: by 10.220.225.194 with SMTP id it2mr17470575vcb.32.1345655602277;
 Wed, 22 Aug 2012 10:13:22 -0700 (PDT)
Received: by 10.58.29.233 with HTTP; Wed, 22 Aug 2012 10:13:22 -0700 (PDT)
In-Reply-To: <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204034>

On Wed, Aug 22, 2012 at 10:00 AM, Brandon Casey <drafnel@gmail.com> wrote:
> Also, we have xstrndup.  So I think the body of your function can become
> something like:
>
>    if (len && dir[len-1] == '/')
>        dir = tmp_dir = xstrndup(dir, len-1);
>
>    retval = mkdir(dir, mode);
>    free(tmp_dir);

Actually, xmemdupz could be used in place of xstrndup since we've
already called strlen.

-Brandon
