From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 16/15] Add tracing to measure where most of the time is spent
Date: Wed, 20 Apr 2016 19:36:02 +0700
Message-ID: <CACsJy8A_M7pjVFea3oK82dz5h7SHJ=-eCEwUmv6St6q1YOuwEw@mail.gmail.com>
References: <1461108489-29376-16-git-send-email-dturner@twopensource.com>
 <1461146394-5135-1-git-send-email-pclouds@gmail.com> <alpine.DEB.2.20.1604201427440.2826@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 20 14:36:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asrMz-0007YT-PN
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 14:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933072AbcDTMge convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Apr 2016 08:36:34 -0400
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35419 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354AbcDTMgd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2016 08:36:33 -0400
Received: by mail-lf0-f50.google.com with SMTP id c126so39979732lfb.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 05:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ga8RG4t6kw3Anoenz4+c0GsfyPw5UhuXbG7aeFpJFds=;
        b=qVeB87zpmxGSo9OuDuFohlMQNgdT6CMjV9z0eLEz16czMa/oLnIDsrLiY/MSJitBQD
         V1W51Skb6z7rkOC7+xTFbfIG/NWzX8vU2rzASY0rRjyQC1+r/VFqcncXvnNnRLuv04qA
         Ne9F2gN+Z3Nzo0DbNFMRN7uJNVyGPMkiq0eL4eN14QN3kVQhniMR8krPKjnUqgJ3P+Xe
         imW5U84e9oiggjeEeuzjmo3p6XrvYFhiNY7ZR6hbpMp9MkP+g8X2cl0JPyVs8huVU5f+
         /rrVxKKMSubdg3NSvKFE2dnkecEiwfgEoGXYrOBTqr2b9Jty7+d9hJN+v4e+CUIGi4Pk
         bpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ga8RG4t6kw3Anoenz4+c0GsfyPw5UhuXbG7aeFpJFds=;
        b=aTGwOli7OyydmRU4equVdSAZan+Jb+osVyuNQGYghmzA+wHSUUaMKGTqYSz7HdnvF6
         RC3ZLnDuXba+ot+ZLRyHQ38oXBMu/Q3Qd5ceeH2vmK9Xxk+hC8VlWtmuAmBwvCyGiu5z
         vU7d6MV1TCN9T2VpVbdncCFvDhdzbp54QWVfYveOfY4cwBZQsyD33sMaNCb6pjWoZriM
         3pv48OdbjO9IoBw9QKTvRkATUw2d7i5CLKrHfuqswYddjLGHMC02X1NWWQk3o7VVbrhb
         PQmQqURpEBp/n4wPq9xLBLBmb6oa0qDgkpAdSqkXlC2RH1uqlsxrd1Qh0Xn02O9UMTqC
         g/EA==
X-Gm-Message-State: AOPr4FWuUqr7vJEOMIn2jD01bPgkmKetMqlMTqnnH4R4Xq3Dj5AbtDiVgKLUrsFmjKJfDcUwWn3QNEAT7o1cog==
X-Received: by 10.25.23.155 with SMTP id 27mr1090439lfx.3.1461155791738; Wed,
 20 Apr 2016 05:36:31 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 20 Apr 2016 05:36:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1604201427440.2826@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292008>

On Wed, Apr 20, 2016 at 7:28 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Wed, 20 Apr 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> All the known heavy code blocks are measured (except object database
>> access). This should help identify if an optimization is effective o=
r
>> not. An unoptimized git-status would give something like below (92% =
of
>> time is accounted). To sum up the effort of making git scale better:
>>
>>  - read cache line is being addressed by index-helper
>>  - preload/refresh index by watchman
>>  - read packed refs by lmdb backend
>>  - diff-index by rebuilding cache-tree
>>  - read directory by untracked cache and watchman
>>  - write index by split index
>>  - name hash potientially by index-helper
>>
>> read-cache.c:2075         performance: 0.004058570 s: read cache ...=
/index
>> preload-index.c:104       performance: 0.004419864 s: preload index
>> read-cache.c:1265         performance: 0.000185224 s: refresh index
>> refs/files-backend.c:1100 performance: 0.001935788 s: read packed re=
fs
>> diff-lib.c:240            performance: 0.000144132 s: diff-files
>> diff-lib.c:506            performance: 0.013592000 s: diff-index
>> name-hash.c:128           performance: 0.000614177 s: initialize nam=
e hash
>> dir.c:2030                performance: 0.015814103 s: read directory
>> read-cache.c:2565         performance: 0.004052343 s: write index, c=
hanged mask =3D 2
>> trace.c:420               performance: 0.048365509 s: git command: '=
=2E/git' 'status'
>
> Thank you for doing this! It will be *highly* valuable to get the
> performance on Windows where I want it to be, too.

Just to be clear, these are unoptimized numbers, no untracked cache,
no split index, no index helper, and on a tiny repository that is
git.git. It's mostly to show the percentage of time spent in each
phase. We probably can do similar measurement and record it in the
watchman patch (can't wait for lmdb to be here :).
--=20
Duy
