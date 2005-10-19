From: "H. Peter Anvin" <hpa@zytor.com>
Subject: The git protocol and DoS
Date: Wed, 19 Oct 2005 13:00:05 -0700
Message-ID: <4356A5C5.5080905@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 19 22:02:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESK6o-00085N-R0
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 22:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVJSUAT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 16:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVJSUAT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 16:00:19 -0400
Received: from terminus.zytor.com ([192.83.249.54]:36549 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751266AbVJSUAS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 16:00:18 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9JK0AXF002706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 19 Oct 2005 13:00:11 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10300>

I've been concerned for a while that the git protocol may be inherently 
vulnerable to a "SYNful DoS" attack (spraying raw TCP SYN packets with 
enough data to start substantial server activity.)  Although SYN cookies 
protect against this to some degree, it makes me wonder if something 
should be added to the protocol itself.

One way to do this would be to start the transaction by having the 
server transmit a cookie to the client, and to require the client to 
send a SHA1 of the (cookie + request) together with the request.  This 
would be done with a fairly short timeout.

It would, however, require a protocol change; I would like to hear what 
people think about this at this stac=ge.

	-hpa
