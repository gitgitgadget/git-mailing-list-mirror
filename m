From: madmarcos <fru574@my.utsa.edu>
Subject: calculating a git packfile sha1 checksum in java
Date: Tue, 22 Mar 2011 02:27:24 -0700 (PDT)
Message-ID: <1300786044816-6195501.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 10:27:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1xsA-0004zi-U2
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 10:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328Ab1CVJ1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 05:27:25 -0400
Received: from sam.nabble.com ([216.139.236.26]:40832 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203Ab1CVJ1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 05:27:25 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <fru574@my.utsa.edu>)
	id 1Q1xs4-0004UI-Qj
	for git@vger.kernel.org; Tue, 22 Mar 2011 02:27:24 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169716>

I am learning about the Git packfile and currently trying to reproduce (in
Java) what I believe to be the SHA1 20-byte checksum for the entire
packfile. I take the byte array from, and including, the "PACK" 4-byte
header to the end of the last packaged object's compressed data. Everything
I have read indicates that the next 20 bytes is the SHA1 checksum for the
entire packfile.

The 20-byte checksum that is part of the byte array received from Git is:
B910248BF9B63AC53595E3835CA57BDAF08DA830

I use the following to calculate my own SHA1 checksum: 
crypt = MessageDigest.getInstance("SHA-1");
crypt.reset();
crypt.update(testData);
byte [] result = crypt.digest();

My result ends up as: B910248BF9B63AC53595E3835CA57BDAF08DA813

I am baffled at how only the last byte of my result can be different from
Git's (if I am using the correct part of the byte stream). If the only
problem was the range of data passed to digest() then the entire calculated
checksum would most likely look different.

Any ideas?

Note: I use the same code to generate test SHA1 ids for each contained
object and they match the references in the tree objects. This problem
currently only involves calculating the checksum over the entire packfile.

--
View this message in context: http://git.661346.n2.nabble.com/calculating-a-git-packfile-sha1-checksum-in-java-tp6195501p6195501.html
Sent from the git mailing list archive at Nabble.com.
