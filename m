From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [RFH] GSoC 2015 application
Date: Fri, 20 Feb 2015 11:22:43 +0100
Message-ID: <1424427763.30155.28.camel@kaarsemaker.net>
References: <20150218191417.GA7767@peff.net> <vpqzj8ary29.fsf@anie.imag.fr>
	 <20150220020022.GC16124@peff.net> <vpqwq3cdhhe.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 20 11:22:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOkjU-0007JU-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbbBTKWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:22:49 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:59889 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbbBTKWs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 05:22:48 -0500
Received: by mail-wg0-f45.google.com with SMTP id k14so12305195wgh.4
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 02:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=0U7aZV/xahIwfhh1OW4jyX1GbAoGfdzu6A+8dIwaM/E=;
        b=eQ3DbHc+DFbVnmPTGc1MFllKDcBJS5wUl1yrF+/0sZ1X99ZI4/rUUpNt+FELJMFkT/
         +D0r4u54zAuybVaNhP5oPmq61bLS5lmlEgeaRqZQvyejC4UXo1oJKvNLNFHbveMdVFT/
         9PbxlqrKzGIInApun/1n9iNVS0sJuxPIxAZ/0d94oRmkNh2ydN/0mYzi3f2Fr1lBpFgg
         OONFw8gb6PfXeCUrXUMtlaiW8PC55b+ZYWOgneJr4DRv+YVwKKvfH0Avna9hir461TeA
         oqq1S8qWvpJCRGQLnXGuxLHCyFzjvtPXTC7/zdQrNX99xymtb7Ei4BpDm2zWHPZHgWhE
         MD/Q==
X-Gm-Message-State: ALoCoQmmmFYlwQ6MTRxvfxtsL+Y+TTe3RpVlnwkbuiu65lFFHXgMbMZ7Ef8Tsv8ak/QHF3KQ0HMS
X-Received: by 10.194.59.112 with SMTP id y16mr18197618wjq.36.1424427766655;
        Fri, 20 Feb 2015 02:22:46 -0800 (PST)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id c4sm1736937wik.0.2015.02.20.02.22.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Feb 2015 02:22:45 -0800 (PST)
In-Reply-To: <vpqwq3cdhhe.fsf@anie.imag.fr>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264150>

On vr, 2015-02-20 at 11:06 +0100, Matthieu Moy wrote:
> The ~/.git-credential-cache may be a bit harder, but the case of
> ~/.git-credentials should follow the same pattern as files for which
> this is already done. So, doing it by mimicking existing code
> shouldn't
> be too hard.
> 
> But maybe that's me being optimistic ;-)

Having just copied that logic to one of my tools, I reaclly would have
fount if useful to have something that, given a config file name tells
you where it should be, maybe in the resident kitchen-sink that is
rev-parse:

$ git rev-parse --config git
/home/dennis/.gitconfig
$ git rev-parse --config gitk
/home/dennis/.gitk
$ git rev-parse --config foobar
/home/dennis/.foobar

Or, when XDG config files are used:

$ git rev-parse --config gitk
/home/dennis/.config/git/gitk
$ git rev-parse --config git
/home/dennis/.config/git/config
$ git rev-parse --config foobar
/home/dennis/.config/git/foobar

So, ~/.$filename or $XDG_CONFIG_HOME/git/filename, with a special case
only for git itself, with consistent selection of which to use
(currently gitk and git are inconsistent).

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
