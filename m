From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] git-p4: Use -m when running p4 changes
Date: Tue, 14 Apr 2015 12:25:32 +0100
Message-ID: <CAE5ih79UcJfuhzgTdTPy2K51sa6--4bvaVaKL3nsUcC2kq4Ffg@mail.gmail.com>
References: <CALM2SnY62u3OXJOMSqSfghH_NYwZhzSedm3-wcde-dQCX6eB9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>
To: Lex Spoon <lex@lexspoon.org>
X-From: git-owner@vger.kernel.org Tue Apr 14 13:25:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhyyJ-00066h-Af
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 13:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbbDNLZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 07:25:35 -0400
Received: from mail-vn0-f54.google.com ([209.85.216.54]:33472 "EHLO
	mail-vn0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423AbbDNLZd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 07:25:33 -0400
Received: by vnbf1 with SMTP id f1so2320180vnb.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZAWX28SbeZZ4YaaNlJC4+CSMXvt+I7s1DxO0H1M4yFA=;
        b=dI0eXffZeK1zA0/djLfiRtCmSTyMf0+iwjuauZ8F3PUzuwY6lKtXko1ZbQxG934mU9
         vWHPVSnKSOhbL5fgGv8TnDxwgznx+Ctp2I/9i3Zod8QTnHLgJCbOyIgvhIkQl5Z5dT+w
         T3N7KBnVC+6nnjkk+YeckYKieFdFJS/WpyZNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ZAWX28SbeZZ4YaaNlJC4+CSMXvt+I7s1DxO0H1M4yFA=;
        b=F8NG1nXU/fO9haGrcOEyna92C9ih9kytnUEDDaLQUtwbvc+8UrrkuzeCkuxmS0WmZV
         7lDUt8No9wdRgdWKlX2REVmCMjrVTjgyATMDexy4CPzlpRCqD9ZxrXmEWVm4EMERWnov
         zo/1aW2p+/hGmTkTQeNPx1mhmXQNH0pRalUjwfUqfGmURjoOztQkcXY7zLDV+i4WraQz
         pU75NFMvKB3ozWAKuwp+X4XFuMnKwhLYGrZhTzpmfQeCNsCUvvv4YT0ulSRIht2qdEz9
         fkpdJM8PjktRtIxctCxk+q3SeaaUfJo1aNqbq63p6Bf7h2Qyz7ouK22jpaIbBu5QucIB
         w8UA==
X-Gm-Message-State: ALoCoQlL9WSTr587KkudaEqGQFmCjVVRyICbIBC7sWdnfiCxPsXSyLGCsDH5lTn12PBa55+X7PT9
X-Received: by 10.202.198.149 with SMTP id w143mr10989521oif.72.1429010732643;
 Tue, 14 Apr 2015 04:25:32 -0700 (PDT)
Received: by 10.60.59.167 with HTTP; Tue, 14 Apr 2015 04:25:32 -0700 (PDT)
In-Reply-To: <CALM2SnY62u3OXJOMSqSfghH_NYwZhzSedm3-wcde-dQCX6eB9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267130>

On 11 April 2015 at 16:17, Lex Spoon <lex@lexspoon.org> wrote:
>
>
> Signed-off-by: Lex Spoon <lex@lexspoon.org>
> ---
> This patch addresses a problem I am running into with a client. I am
> attempting to mirror their Perforce repository into Git, and on certain
> branches their Perforce server is responding with an error about "too many
> rows scanned". This change has git-p4 use the "-m" option to return just 500
> changes at a time, thus avoiding the problem.

Thanks - that's a problem I also occasionally hit, and it definitely
needs fixing.

Your fix is quite nice - I started out thinking this should be easy,
but it's not!

A test case addition would be good if you can though - otherwise it's
certain to break at some point in the future. Would you have time to
add that?

Thanks!
Luke


>
> I have tested this on a small test repository (2000 revisions) and it
> appears to work fine. I have also run all the t98* tests; those print a
> number of yellow "not ok" results but no red ones. I presume this is the
> expected test behavior?

Yes.

>
> I considered making the block size configurable, but it seems unlikely
> anyone will strongly benefit from changing it. 500 is large enough that it
> should only take a modest number of iterations to scan the full changes
> list, but it's small enough that any reasonable Perforce server should allow
> the request.

Might be useful when making test harnesses though :-)


>
> This patch is also available on GitHub:
> https://github.com/lexspoon/git/tree/p4-sync-batches
>
>  git-p4.py | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 549022e..ce1447b 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -742,15 +742,41 @@ def originP4BranchesExist():
>
>  def p4ChangesForPaths(depotPaths, changeRange):
>      assert depotPaths
> -    cmd = ['changes']
> -    for p in depotPaths:
> -        cmd += ["%s...%s" % (p, changeRange)]
> -    output = p4_read_pipe_lines(cmd)
>
> +    # Parse the change range into start and end
> +    if changeRange is None or changeRange == '':
> +        changeStart = '@1'
> +        changeEnd = '#head'
> +    else:
> +        parts = changeRange.split(',')
> +        assert len(parts) == 2
> +        changeStart = parts[0]
> +        changeEnd = parts[1]
> +
> +    # Accumulate change numbers in a dictionary to avoid duplicates
>      changes = {}
> -    for line in output:
> -        changeNum = int(line.split(" ")[1])
> -        changes[changeNum] = True
> +
> +    for p in depotPaths:
> +        # Retrieve changes a block at a time, to prevent running
> +        # into a MaxScanRows error from the server.
> +        block_size = 500
> +        start = changeStart
> +        end = changeEnd
> +        get_another_block = True
> +        while get_another_block:
> +            new_changes = []
> +            cmd = ['changes']
> +            cmd += ['-m', str(block_size)]
> +            cmd += ["%s...%s,%s" % (p, start, end)]
> +            for line in p4_read_pipe_lines(cmd):
> +                changeNum = int(line.split(" ")[1])
> +                new_changes.append(changeNum)
> +                changes[changeNum] = True
> +            if len(new_changes) == block_size:
> +                get_another_block = True
> +                end = '@' + str(min(new_changes))
> +            else:
> +                get_another_block = False
>
>      changelist = changes.keys()
>      changelist.sort()
> --
> 1.9.1
>
