From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCH] Configurable hyperlinking in gitk
Date: Sat, 17 Sep 2011 21:26:15 +1200
Message-ID: <4E7467B7.1090201@gmail.com>
References: <20110917022903.GA2445@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Sat Sep 17 11:26:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4rA5-0001Ea-6W
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 11:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab1IQJ0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 05:26:06 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36079 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753397Ab1IQJ0F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 05:26:05 -0400
Received: by pzk1 with SMTP id 1so4544864pzk.1
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 02:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PUDdbJwjw57BV7CXzmDwnxLJdtKplFyTde9aFCgcLKU=;
        b=vneevbigKg9wsJmlsvwYl44u5lQhBZy3gfY6/bNenzYflV6d/ESJiCYhJLvS1CfLUv
         4220lIeZ3ttPOEqQq68ndSM2Vt27PNACfxM3POl3ga1i+yELf/rbzxutw6XNVg+ZA3Oh
         EvZCJuZcosflUrEK+BB+m33RK/ZZ9xu3mf3HA=
Received: by 10.68.27.195 with SMTP id v3mr600621pbg.372.1316251563221;
        Sat, 17 Sep 2011 02:26:03 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id q10sm4686637pbn.9.2011.09.17.02.26.00
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Sep 2011 02:26:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.20) Gecko/20110804 SUSE/3.1.12 Thunderbird/3.1.12
In-Reply-To: <20110917022903.GA2445@unpythonic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181573>

Hi,

On 17/09/11 14:29, Jeff Epler wrote:
> Some time ago I hardcoded this into gitk for $DAY_JOB and find it very
> useful.  I made it configurable in the hopes that it might be adopted
> upstream. (unfortunately, the configurable version is radically
> different from the original hard-coded version, so I can't say this
> has had much testing yet)

This is definitely something folks at my $dayjob would be interested in.
We've already done some customisation of gitweb to do something similar.
I'm not actually sure what the changes where or how configurable they
are. I'll see if I can dig them out on Monday someone else might want to
polish them into something suitable (I might do it myself if I get some
tuits).

> The definition of the allowed regular expression in the docs
> probably needs some refinement.  Basically, they have to also be REs
> that can be concatenated with the "|" character, which is not true
> of REs that begin with the *** flavor selector (which I had not
> heard of before rereading `man re_syntax` just now) or (?xyz)
> embedded options.  Or maybe there's an efficient alternate approach
> to scanning for the next non-overlapping match among several
> patterns that doesn't involve concatenating the patterns.
> 
> I'm not sure about the "one line" restriction; at first I thought
> that everything was fed to 'appendwithlinks' in arbitrary chunks,
> but not I see that they are mostly logical chunks (and probably only
> the comment, not the headers or commit descriptors, will have
> anything to linkify).  The problem again seems to be how to succinctly
> describe what is permitted.

For my use case the one line restriction is fine. We tend to put the bug
number in the headline anyway.

Sometimes when a commit fixes multiple bugs we put all the bug numbers
in separated by commas. I don't know Tcl well enough to tell if your
code supports that or not.

> There are probably better names for the configuration options, too.

It'd be nice if the config variables weren't gitk specific. .re and .sub
could be applied to gitweb and maybe other git viewers outside of
gig.git might decide to use them. My bikeshedding suggestion would be to
just drop the gitk prefix and have linkify.re and linkify.sub.

> Suggestions?  Problems?  Successes?

Re-compiling now. I won't be able to actually test it properly until I'm
back in the office but I can at least check that the links are generated.
