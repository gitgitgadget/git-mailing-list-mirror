From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH v3] autoconf: Test FREAD_READS_DIRECTORIES
Date: Tue, 4 Mar 2008 15:32:49 +0000
Message-ID: <e2b179460803040732k222651c2vdb04e553b8137891@mail.gmail.com>
References: <200803041514.42783.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: "Michal Rokos" <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 04 16:33:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZ8y-0002fo-AD
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 16:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759005AbYCDPcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 10:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759438AbYCDPcv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 10:32:51 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:63721 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758837AbYCDPcu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 10:32:50 -0500
Received: by rv-out-0910.google.com with SMTP id k20so530135rvb.1
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZKQswb57RjCs3PIPUzweK8SMysiAWUeBGBRWKAJBHAQ=;
        b=k8SrzXzMgqWPQNY35OcQT7zhwooRhGY0UO95JpJGNd5Bzp93xSMExJm+qjSZhHy71wtuIfB/I+aApAfyae+heZGwpEIO+Orz636Y70mnp3K04ftHJjgdnQf5AJFpfqcU9o7hfzbgtKvoZSbiBa/K6dRKsKkBLRFViJ5lOI/iF1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lh6StlEPwYTPfL4N24bbylZUoC2PpcMV6b35tTyBtBrbrWOoCilVhVnGqk4ZTN8cCC23ZoC3r8lXl4tXl41VVQ0De5We6t/9iPfMh36buJh59Rzeg9m73AwbqfbeHBh20xq2kqxECqSIIdkTraLqrAaJXnw5cfmYd/P1AUUUKGo=
Received: by 10.141.33.21 with SMTP id l21mr687496rvj.105.1204644769887;
        Tue, 04 Mar 2008 07:32:49 -0800 (PST)
Received: by 10.141.19.11 with HTTP; Tue, 4 Mar 2008 07:32:49 -0800 (PST)
In-Reply-To: <200803041514.42783.michal.rokos@nextsoft.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76101>

On 04/03/2008, Michal Rokos <michal.rokos@nextsoft.cz> wrote:
> Add test for FREAD_READS_DIRECTORIES to configure script.
>
>  When "." could be opened and fread reads more than 0 items,
>  FREAD_READS_DIRECTORIES will be set.

On AIX 5.3 this appears to work correctly, i.e. it defines
FREAD_READS_DIRECTORIES

I've negatively tested it just by swapping the return values.

It is susceptible to failing for other reasons than those expected
(i.e. the configure script gets the libsocket test wrong on my
platform if I forget to amend CFLAGS because libg is not available,
and then various tests including this one fail because libsocket is
erroneously linked in and the test programs fail to compile at all),
but that is I think a wider issue with autoconf tests in general.

So, with those caveats:

Tested-by: Mike Ralphson <mike@abacus.co.uk>

Patch to set this option by default on AIX for the non-autoconf
Makefile to follow.
