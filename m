From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 5/6 (v4)] full integration of rev-cache into git,   completed
 test suite
Date: Wed, 30 Sep 2009 10:09:29 +0200
Message-ID: <4AC31239.609@viscovery.net>
References: <op.uzv4covmtdk399@sirnot.private> <1254297229-14806-1-git-send-email-chris_johnsen@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Nick Edelen <sirnot@gmail.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 10:09:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsuFv-0005iB-My
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 10:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbZI3IJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 04:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbZI3IJf
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 04:09:35 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:16972 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbZI3IJf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 04:09:35 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MsuFe-0005oL-34; Wed, 30 Sep 2009 10:09:30 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B57FA4E4; Wed, 30 Sep 2009 10:09:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1254297229-14806-1-git-send-email-chris_johnsen@pobox.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129334>

Chris Johnsen schrieb:
> -cache_size=`wc -c .git/rev-cache/$cache_sha1 | grep -o "[0-9]*"`
> +cache_size=`wc -c < .git/rev-cache/$cache_sha1 | tr -d ' '`
>  test_expect_success 'test --ignore-size function in fuse' '
>  	git-rev-cache fuse --ignore-size=$cache_size 2>output.err &&
>  	grep "final return value: 0" output.err &&

You can also have the shell strip the blanks:

cache_size=$(wc -c < .git/rev-cache/$cache_sha1)
test_expect_success 'test --ignore-size function in fuse' '
	git-rev-cache fuse --ignore-size=${cache_size##* } 2>output.err &&
	grep "final return value: 0" output.err &&

-- Hannes
