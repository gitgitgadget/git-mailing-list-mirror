From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC/PATCH] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Tue, 09 Dec 2014 20:58:26 +0100
Message-ID: <54875462.3040305@kdbg.org>
References: <20141209174958.GA26167@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 20:58:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyQvb-0001ty-1H
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 20:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbaLIT6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 14:58:31 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:22664 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbaLIT6a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 14:58:30 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jxsdb5cMcz5tlQ;
	Tue,  9 Dec 2014 20:58:27 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CA3E719F828;
	Tue,  9 Dec 2014 20:58:26 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141209174958.GA26167@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261149>

Am 09.12.2014 um 18:49 schrieb Jeff King:
> +test_expect_success 'create repo with absurdly long refname' '
> +	ref240=$_z40/$_z40/$_z40/$_z40/$_z40/$_z40
> +	ref1440=$ref240/$ref240/$ref240/$ref240/$ref240/$ref240 &&
> +	git init long &&
> +	(
> +		cd long &&
> +		test_commit long &&
> +		test_commit master &&
> +		git update-ref refs/heads/$ref1440 long

Having this ref on the filesystem is going to fail on Windows, I presume
(our limit is 260). Can we stuff it away as a packed ref right from the
beginning? (And turn off reflogs, BTW.)

> +	)
> +'

-- Hannes
