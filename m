From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/24] merge script: --squash, --ff from unborn branch are
 errors
Date: Tue, 17 Aug 2010 02:03:07 -0500
Message-ID: <20100817070307.GL22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 09:04:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGE4-0000H5-T7
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823Ab0HQHEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 03:04:43 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56618 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756715Ab0HQHEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 03:04:42 -0400
Received: by ywh1 with SMTP id 1so2271213ywh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TXuPamDXKSgKX5RvNlZAxT6MfJugD2m3uxNO5vKTpp0=;
        b=ElM8jldOefBj1gYZK2SuBBvxEivC8ag20FIeG5KmnYT/lk1qZG2tADMos7wCFLLbT9
         h4HBE3RSg9piKn9CYAHdULNklMU4EqDsDWh+c7y7CAAyke/tBefjNOlG0uXithfZKSlr
         9oInKgpo6cNmwS+zzAvIjd39M0DnWoXtrTYfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uI9oG3l86PZGdgus5766hZYxojGYrEn5rU71y7Deh3Nx9qacql+h6d7/u+q7t64K+w
         Nxa3Vt3DxRuSPHMkSoh+MsQxmO8Z3qPMXyd1R5bpXknMHXaGX/ybqeiXcJlnSD7V8Act
         QcfyBG0eF/tjTcBQEPli8aZcacbhWp+tnPGv4=
Received: by 10.150.53.21 with SMTP id b21mr6707003yba.350.1282028682200;
        Tue, 17 Aug 2010 00:04:42 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q21sm7506000ybk.23.2010.08.17.00.04.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 00:04:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153715>

Port v1.6.1-rc1~319 (provide more errors for the "merge into empty
head" case, 2008-08-21) to the example merge script.

Noticed by comparison with builtin merge.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/examples/git-merge.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/examples/git-merge.sh b/contrib/examples/git-merge.sh
index 8f617fc..72853cf 100755
--- a/contrib/examples/git-merge.sh
+++ b/contrib/examples/git-merge.sh
@@ -245,6 +245,10 @@ then
 		exit 1
 	fi
 
+	test "$squash" != t ||
+		die "Squash commit into empty head not supported yet"
+	test "$allow_fast_forward" = t ||
+		die "Non-fast-forward into an empty head does not make sense"
 	rh=$(git rev-parse --verify "$1^0") ||
 		die "$1 - not something we can merge"
 
-- 
1.7.2.1.544.ga752d.dirty
