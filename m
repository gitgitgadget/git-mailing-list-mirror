From: Tony Finch <dot@dotat.at>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 4 Jun 2009 12:41:14 +0100
Message-ID: <alpine.LSU.2.00.0906041157221.9226@hermes-2.csi.cam.ac.uk>
References: <200905122329.15379.jnareb@gmail.com> <200906032320.23559.jnareb@gmail.com> <alpine.LSU.2.00.0906032240300.31588@hermes-2.csi.cam.ac.uk> <200906041045.11328.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 13:41:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCBJz-0007LW-V1
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 13:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510AbZFDLlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 07:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754485AbZFDLlO
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 07:41:14 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:51921 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395AbZFDLlN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 07:41:13 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:52712)
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:25)
	with esmtpa (EXTERNAL:fanf2) id 1MCBJq-0005Ay-2h (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jun 2009 12:41:14 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1MCBJq-0005sE-QZ (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 04 Jun 2009 12:41:14 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <200906041045.11328.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120690>

On Thu, 4 Jun 2009, Jakub Narebski wrote:
>
> But I do not know what are, or what should be protocol requirements.
> Should SHA-1 use lowercase, or be case insensitive? Should commands such
> as "have", "want", "done" use lower case or be case insensitive? Should
> status indicators "ACK" and "NAK" be upper case, or should be case
> insensitive? Should capabilities be case sensitive, and should they be
> compared case sensitive or not?

I think the current (rough) consensus is that case insensitivity causes
pain unless its scope is carefully controlled. I18n causes a lot of the
difficulties.

One way in which you can control the scope is by limiting
case-insensitivity to protocol elements that must be ASCII (commands,
replies, SHA-1 hashes). But I'm not sure there's any benefit to making
the protocol case insensitive, especially when it isn't possible to
type it manually.

I've already given one example of interoperability problems in SMTP
arising from case insensitivity. In the opposite direction, Unix and
XML are good examples of case sensitivity working well in practice.

I have to say I spend all my time working with old-school case insensitive
protocols, and they have clearly been extremely successful, so it's
tempting to copy them. But I think that will lead to ugliness - have a
look through the HTTP spec for its mish-mash of sensitive and insensitive
protocol elements.

In the specific instance of the pkt-length, if all current implementations
write the length in lower case, you can say in the spec it MUST be lower
case. If you do that then the same requirement can apply to both the
client and the server which makes the spec shorter and simpler. Postel's
robustness principle suggests that it doesn't really matter if the parser
treats it case-insensitively.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
