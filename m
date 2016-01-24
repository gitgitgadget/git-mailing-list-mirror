From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Sun, 24 Jan 2016 15:34:03 +0100
Message-ID: <20160124143403.GL7100@hank>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
 <20160119191234.GA17562@sigill.intra.peff.net>
 <xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
 <20160120002606.GA9359@glandium.org>
 <xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
 <DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
 <20160122023359.GA686558@vauxhall.crustytoothpaste.net>
 <20160122055255.GA14657@sigill.intra.peff.net>
 <20160122060720.GA15681@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 24 15:33:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNLjq-0004xA-Rq
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 15:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbcAXOdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 09:33:40 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36041 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbcAXOdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 09:33:38 -0500
Received: by mail-wm0-f47.google.com with SMTP id l65so35988241wmf.1
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 06:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UOgUFOfpZ4Cp7NDYArjTGiuvnTgXWrpaMqoO8ZcPszM=;
        b=zc+AMplwgKrnW+7vWA8zJjpwSMvZcYliWGN4FaNA4fGd8EI4nwHy8yLZyY72NSpnTT
         YFqV/WhA3pkXYHtX9dAHD5Wra/y/jaBVKICv3B7tWAoEaD77AE4aUO/8tS9Vl2Pb2yfx
         7p+PYcxMOslvDglreUuOT3N3HoV/taTbsfAfeuVv+o4rJ5Qk272n1kLhrN6vDgvQHWvm
         koz1nm5NfqmJDa3hYYNNGnTvAg9rYmejqIfEdFTPgTRGZuXTJ+QdAlqmAkeCx2PT4AC1
         86lSSOOAatVUieNMp1P/zTHaqb0ZzMb4V5dE+ObkOtiphBreuclCLdC2CVgvYTX0thHS
         Mt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UOgUFOfpZ4Cp7NDYArjTGiuvnTgXWrpaMqoO8ZcPszM=;
        b=YFiHXsf5z0vfhaTd4P5huY0NYWCh02kz04sFijdDmLDJKL7m4sM3y074XC5TOGBMKk
         I7iHHA6UWegU0GRX6GKH9qwY01Uu9CGZdWp/NKLuGI1Gtt4cbX24NhSluu5JQWiYXqWt
         6J9bKbE/jz0TASRBLyXfb1Fw+CdQXi754eAg9AR8rg8qqFxQ5hITD6Ci6qIOURBRdntt
         wr8/5nqJMXx4UOFxjz1BOpPhtFmjdIEGIwibEW/Uh0h2JuK0qVt8a8ihg1IvSOqEKlak
         LvG/AYnEAHTzU/Aovr0djxao05/2jJ21myWL00r28AKOnEzLW5Eq70zw71hDjqskAuqn
         oIwQ==
X-Gm-Message-State: AG10YOTpTy3D4+pugP6l5mNiEePLIMm8eJNUh1YJzldBDUG2YEKwRGH+jvUW4h+NG/FAZQ==
X-Received: by 10.194.203.99 with SMTP id kp3mr12697126wjc.3.1453646016682;
        Sun, 24 Jan 2016 06:33:36 -0800 (PST)
Received: from localhost (host142-106-dynamic.249-95-r.retail.telecomitalia.it. [95.249.106.142])
        by smtp.gmail.com with ESMTPSA id i196sm11730015wmf.23.2016.01.24.06.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jan 2016 06:33:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160122060720.GA15681@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284649>

On 01/22, Jeff King wrote:
> On Fri, Jan 22, 2016 at 12:52:55AM -0500, Jeff King wrote:
>
> > I get a few of the threads failing (in test 4) after 2-3 minutes. The
> > "-v" output is pretty unenlightening, though. I don't see anything
> > racy-looking in the test unless it is something with "read-tree" and
> > stat mtimes.
>
> And indeed, doing this:
>
> diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
> index c164b46..d34775b 100755
> --- a/t/t0025-crlf-auto.sh
> +++ b/t/t0025-crlf-auto.sh
> @@ -56,6 +56,7 @@ test_expect_success 'text=true causes a CRLF file to be normalized' '
>
>  	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
>  	echo "CRLFonly text" > .gitattributes &&
> +	sleep 1 &&
>  	git read-tree --reset -u HEAD &&
>
>  	# Note, "normalized" means that git will normalize it if added
>
> let me run for over 5 minutes with no failures in test 4 (I eventually
> did hit one in test 9). I don't claim to understand what is going on,
> though.

I don't think this is the right solution though, I think this mostly
lessens the load on the filesystem so the flakiness doesn't occur,
especially on your system, where it seems hard to trigger in the first
place :)

I actually hit the same problem occasionally when running the test
suite before, but was always to lazy to try to reproduce it.  Thanks
to your reproduction I think I was able to track the underlying
problem down.

My analysis is in the commit message below.

--->8---
Subject: [PATCH] entry: fix up to date marking

write_entry always marks cache entries up to date when
state->refresh_cache is set.  This is however not always accurate,
if core.autocrlf is set in the config, a file with cr and lf line
endings exists and the file attribute is set to text or crlf in the
gitattributes.

Most notably this makes t0025 flaky.  When calling deleting the files
that will be adjusted through the automated crlf handling, and then
calling `git read-tree --reset -u HEAD`, this leads to a race between
git read-tree and the filesystem.  The test currently only passes
most of the time, because the filesystem usually isn't synced between
the call to unpack_trees() and write_locked_index().

Currently the sequence of 1) remove files with cr and lf as line
endings, 2) `git read-tree --reset -u HEAD` 3) checking the status of
the changed files succeeds, because the index and the files are written
at the same time, so they have the same mtime.  Thus when reading the
index the next time, the files are recognized as racy, and the actual
contents on the disk are checked for changes.

If the index and the files have different mtimes however, the entry is
written to the index as up to date because of the flag set in
entry.c:write_entry(), and the contents on the filesystem are not
actually checked again, because the stat data in the index matches.

The failures in t0025 can be consistently reproduced by introducing a
call to sync() between the call to unpack_trees() and
write_index_locked().

Instead of blindly marking and entry up to date in write_entry(), check
if the contents may change on disk first, and strip the CE_UPTODATE flag
in that case.  Because the flag is not set, the cache entry will go
through the racy check when writing the index the first time, and
smudged if appropriate.

This fixes the flaky test as well as the underlying problem.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 entry.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/entry.c b/entry.c
index 582c400..102fdfa 100644
--- a/entry.c
+++ b/entry.c
@@ -214,6 +214,8 @@ finish:
 		if (!fstat_done)
 			lstat(ce->name, &st);
 		fill_stat_cache_info(ce, &st);
+		if (would_convert_to_git(ce->name))
+			ce->ce_flags &= ~CE_UPTODATE;
 		ce->ce_flags |= CE_UPDATE_IN_BASE;
 		state->istate->cache_changed |= CE_ENTRY_CHANGED;
 	}
--
2.7.0.75.g3ee1e0f.dirty
