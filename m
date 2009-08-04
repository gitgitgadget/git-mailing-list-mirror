From: "George Spelvin" <linux@horizon.com>
Subject: Re: x86 SHA1: Faster than OpenSSL
Date: 4 Aug 2009 01:01:38 -0400
Message-ID: <20090804050138.13256.qmail@science.horizon.com>
References: <9e4733910908032007td74ef9fp669d0d958df67c1@mail.gmail.com>
Cc: git@vger.kernel.org, linux@horizon.com
To: jonsmirl@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 04 07:02:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYC9t-0005l8-QW
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 07:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbZHDFBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 01:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbZHDFBk
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 01:01:40 -0400
Received: from science.horizon.com ([71.41.210.146]:22631 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751833AbZHDFBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 01:01:39 -0400
Received: (qmail 13257 invoked by uid 1000); 4 Aug 2009 01:01:38 -0400
In-Reply-To: <9e4733910908032007td74ef9fp669d0d958df67c1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124749>

> Would there happen to be a SHA1 implementation around that can compute
> the SHA1 without first decompressing the data? Databases gain a lot of
> speed by using special algorithms that can directly operate on the
> compressed data.

I can't imagine how.  In general, this requires that the compression
be carefully designed to be compatible with the algorithms, and SHA1
is specifically designed to depend on every bit of the input in
an un-analyzable way.

Also, git normally avoids hashing objects that it doesn't need
uncompressed for some other reason.  git-fsck is a notable exception,
but I think the idea of creating special optimized code paths for that
interferes with its reliability and robustness goals.
