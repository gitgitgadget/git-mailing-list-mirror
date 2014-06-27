From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Tackling Git Limitations with Singular Large Line-seperated
 Plaintext files
Date: Fri, 27 Jun 2014 08:45:02 -0700
Message-ID: <CAJo=hJtJCy96SRYmOxEpEMoEVcaegv0SCG0_AH2u0=bSrHZi_A@mail.gmail.com>
References: <CAJoVafc1LMxmvCiWci3N+AuAZBsABR3Wb3c6c3stw93OJZ7Scw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jarrad Hope <me@jarradhope.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 17:45:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0YLA-0005hq-0M
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 17:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbaF0PpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 11:45:24 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:47017 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbaF0PpX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 11:45:23 -0400
Received: by mail-ig0-f179.google.com with SMTP id uq10so2095937igb.0
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/r3D8b4Lxgg8O3+iAcXfOHAvcuJwhE+fSH7sjWhUpcc=;
        b=E0VhGX9PMb+47Dg1HH6KBbCnJwX1NsTqHHW8l2NVEq50+wGF+ZwkUng5aIzA/JcowT
         6fmuSpTUITTneNJuXO6UKEAg2spH220p0Z0ZtALUlVcQtWoiq8uGsebX+fgxLpYxhule
         ZnrUn/hBrswPXeYQ3R9xGZWr1LZNDX8aj6v60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/r3D8b4Lxgg8O3+iAcXfOHAvcuJwhE+fSH7sjWhUpcc=;
        b=caSKjPxNjNLgzuR4HkhhWjrq2p0tCVqGaRVF7tVsNNMFOH1xmXKA7U9xU9WwjXLyJ1
         A2HTm5cpdgJxHOKMpAnMNRhhjQpsNjMGVeM1PVPLCuOG+nTzMTki+D/B8Y/0yJ9YUWg6
         itBq86npfwyGFQ5GyiWxvS0GtleixLMXA6i9OncGJMRhzgywxFmHeFSoulQU5HJeOtGT
         EdEOiPWR4RAvhhi0cRNfyJxbJl4kduw4qgEHEEp9LKFkTwODmJjCpDt4w9YP1MwC+JSp
         ew+I4wXvu53GpgdbGa52fgCaiPQIuvn5REhpc3CdcOj8Ji/rjAgVyAQea7kBDS84UTOT
         LY3g==
X-Gm-Message-State: ALoCoQmRAJ4A8VOTlhBInqz5JKLTEOz9Y8QymC+Wb8a7np2Gv40OUmaTCYJ5ViSzDKG7fg2O3MS9
X-Received: by 10.42.91.1 with SMTP id n1mr3448532icm.76.1403883922163; Fri,
 27 Jun 2014 08:45:22 -0700 (PDT)
Received: by 10.64.208.12 with HTTP; Fri, 27 Jun 2014 08:45:02 -0700 (PDT)
In-Reply-To: <CAJoVafc1LMxmvCiWci3N+AuAZBsABR3Wb3c6c3stw93OJZ7Scw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252558>

On Fri, Jun 27, 2014 at 1:45 AM, Jarrad Hope <me@jarradhope.com> wrote:
> As a software developer I've used git for years and have found it the
> perfect solution for source control.
>
> Lately I have found myself using git in a unique use-case - modifying
> DNA/RNA sequences and storing them in git, which are essentially
> software/source code for cells/life. For Bacteria and Viruses the
> repo's are very small <10mb & compress nicely.
>
> However on the extreme end of the spectrum a human genome can run in
> at 50gb or say ~1gb per file/chromosome.

Interesting. Unfortunately not everything is used like source code. :)

Git does source code well. I don't know enough to judge if DNA/RNA
sequence storage is similar enough to source code to benefit from
things like `git log -p` showing deltas over time, or if some other
algorithm would be more effective.

> From my understanding the largest problem revolves around git's delta
> discovery method, holding 2 files in memory at once - is there a
> reason this could not be adapted to page/chunk the data in a sliding
> window fashion ?

During delta discovery Git holds like 11 files in memory at once. One
T is the target file that you are trying to delta compress. The other
10 are in a window and Git compares T to each one of them in turn,
selecting the file that produces the smallest delta instruction
sequence to recreate T.

Because T is compared to 10ish other files (the window size is
tuneable), Git needs a full copy of T in memory for the entire compare
step. For any single compare, T is scanned through only once. If you
were doing a single compare (window size of "1"), T could be "on disk"
and paged through sequentially.

The files in the window need to be held entirely in memory, along with
a matching index. The actual delta compression algorithm is a
Rabin-Karp sliding window hash function. Copies can be made from any
part of the source file with no regard to ordering. This makes
paging/chunking the source file at both compression and decompression
time nearly impossible. Git jumps around the source file many times,
but it allows for efficient storage for movement of long sequences
within a file (e.g. move function foo() later in the file).

Maybe if you limited the window to 1 and limited the hash function to
avoid backing up in the source file so it could be paged, you can get
somewhere.


But you mentioned the files are O(1 GiB). Just buy more RAM? Modern
workstations have pretty good memory capacity.
