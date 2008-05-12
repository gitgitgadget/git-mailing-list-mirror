From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Mon, 12 May 2008 18:17:05 +0100
Message-ID: <e1dab3980805121017u4c244d25s76b39cf015f6c5c5@mail.gmail.com>
References: <20080512122900.GA13050@mithlond.arda.local>
	 <20080512155243.GA3592@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon May 12 19:18:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvbey-0008ND-3d
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 19:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbYELRRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 13:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754358AbYELRRJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 13:17:09 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:60073 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbYELRRG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 13:17:06 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1351165ywe.1
        for <git@vger.kernel.org>; Mon, 12 May 2008 10:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9u79QYWoGKCCKaiW5JPS4xE8Jz+ulqUwVEYfbuUsd8Q=;
        b=xWj8ZCDFEVu1uBb/XIMshxFWFuWc/nUJ/CS7K3KuI+Bn9Qta6gJfJMBlogj3L/5UVOjoOfW+yvbhUWpopthv1rbislAHmWbSxVKY1GUxLUIymvPCiofCROAhHq3pFziMpbpEqcc1ldcYqhXx/P4z7K4tIwzeX1A/tqGyz4DNLtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H+qcOoKNSAli9980e1A+fztrsXGB/AGiNR5brmELdrnpy9Yah3vhwgC1HOw1MlgohUahGGibWa2juI65Oodly7xUvAiSe3DxJCrvo9tjfjxGtiPEyEOJ7UUM19e860CErS8gfQDST/vRJ2B8roP6NkNKKgNp6WX9bq0HrAfka1Q=
Received: by 10.150.69.3 with SMTP id r3mr8513907yba.108.1210612625720;
        Mon, 12 May 2008 10:17:05 -0700 (PDT)
Received: by 10.150.145.6 with HTTP; Mon, 12 May 2008 10:17:05 -0700 (PDT)
In-Reply-To: <20080512155243.GA3592@mithlond.arda.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81883>

On Mon, May 12, 2008 at 4:52 PM, Teemu Likonen <tlikonen@iki.fi> wrote:
> Teemu Likonen wrote (2008-05-12 15:29 +0300):
> Probably a crazy idea: What if "gc --aggressive" first removed *.keep
> files and after packing and garbage-collecting and whatever it does it
> would add a .keep file for the newly created pack?

My understanding is that the repacking with -a redoes the computation
to repack ALL the objects in every pack and loose objects, whereas
what would be preferred is to try to delta new objects (loose and
packed) against the existing .keep pack (extending it with the new
objects) but not trying to re-deltify objects in the .keep pack. This
is because .keep files are primarily for those who are cloning onto a
machine that isn't powerful (maybe even a laptop/palmtop) but who are
cloning from a powerful server, so that you wouldn't necessarily want
to apply your strategy unconditionally.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
