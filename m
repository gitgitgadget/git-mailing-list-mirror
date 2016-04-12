From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Migrating away from SHA-1?
Date: Tue, 12 Apr 2016 15:38:04 -0700
Message-ID: <570D78CC.9030807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 00:38:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq6x7-0001Th-Tc
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 00:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966538AbcDLWia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 18:38:30 -0400
Received: from terminus.zytor.com ([198.137.202.10]:43626 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966404AbcDLWi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 18:38:29 -0400
Received: from carbon-x1.hos.anvin.org ([67.51.76.21])
	(authenticated bits=0)
	by mail.zytor.com (8.15.2/8.14.5) with ESMTPSA id u3CMcAIl008707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Tue, 12 Apr 2016 15:38:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291305>

OK, I'm going to open this can of worms...

At what point do we migrate from SHA-1?  At this point the 
cryptoanalysis of SHA-1 is most likely a matter of time.

For existing repositories we will need to have a migration mechanism. 
Since we can't modify objects without completely invalidating the 
cryptographic properties, what I would suggest is that we leave the 
existing objects as is, with a persistent lookup table from SHA-1 to 
<new hash>, and have that lookup table signed (e.g. GPG) by the person 
responsible for converting the repository.  This freezes the 
cryptographic status of the existing SHA-1 objects at the time the 
conversion happens.  This is a very good reason to do this before SHA-1 
is actually broken  In contrast. SHA-2 has been surprisingly resistant 
to cryptoanalysis, to the point that SHA-3 was motivated by performance 
and the desire to have a well-tested function based on entirely 
different principles should a generic attack against the common 
structure of MD5/SHA-1/SHA-2 would ever be found.

	-hpa
