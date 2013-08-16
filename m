From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] lookup_object: split up displacement penalty for hash collisions
Date: Fri, 16 Aug 2013 11:26:28 +0200
Message-ID: <8761v6dm0r.fsf@linux-k42r.v.cablecom.net>
References: <1376595306-6335-1-git-send-email-stefanbeller@googlemail.com>
	<87haeqdop3.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <peff@peff.net>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 11:26:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAGIm-00023Y-4U
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 11:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659Ab3HPJ0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 05:26:31 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:40146 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754461Ab3HPJ0a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 05:26:30 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 16 Aug
 2013 11:26:25 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 16 Aug 2013 11:26:28 +0200
In-Reply-To: <87haeqdop3.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Fri, 16 Aug 2013 10:28:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232405>

Thomas Rast <trast@inf.ethz.ch> writes:

> Stefan Beller <stefanbeller@googlemail.com> writes:
>
>> However please do check if this patch brings the promised performance
>> on your own, as you're likely using different hardware and another
>> software setup. Feel free to share your performance differences.
>
> I get this on an i7-M620 laptop from t/perf/p0001-rev-list.sh:
>
>   Test                               HEAD                next                    
>   -------------------------------------------------------------------------------
>   0001.1: rev-list --all             6.29(6.03+0.22)     6.33(6.06+0.24) +0.6%   
>   0001.2: rev-list --all --objects   53.22(52.48+0.54)   54.90(54.15+0.55) +3.2%*
>   -------------------------------------------------------------------------------
>   Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001
[...]
> I trust the laptop numbers less because it has far more thermal (and
> thus throttling) issues, but the runs do show a significant difference,
> though less than you claimed.

Well, as I feared... another run on the same laptop:

Test                               HEAD                next                                            
------------------------------------------------------------------------------
0001.1: rev-list --all             6.41(6.14+0.24)     6.36(6.10+0.23) -0.9%* 
0001.2: rev-list --all --objects   54.60(53.84+0.55)   54.23(53.50+0.53) -0.7%
------------------------------------------------------------------------------
Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
