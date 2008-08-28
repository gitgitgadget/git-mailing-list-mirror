From: Mike Hommey <mh@glandium.org>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 20:04:52 +0200
Organization: glandium.org
Message-ID: <20080828180452.GB14901@glandium.org>
References: <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org> <alpine.DEB.1.10.0808281023200.2713@asgard.lang.hm> <20080828172853.GE21072@spearce.org> <alpine.DEB.1.10.0808281033070.2713@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Aug 28 20:07:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYltA-0004kr-Je
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 20:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443AbYH1SF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 14:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754332AbYH1SF2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 14:05:28 -0400
Received: from vuizook.err.no ([194.24.252.247]:58928 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418AbYH1SF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 14:05:27 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KYlra-0002p1-4T; Thu, 28 Aug 2008 20:05:00 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KYlrY-0004KT-Lv; Thu, 28 Aug 2008 20:04:52 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0808281033070.2713@asgard.lang.hm>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94106>

On Thu, Aug 28, 2008 at 10:37:04AM -0700, david@lang.hm wrote:
> On Thu, 28 Aug 2008, Shawn O. Pearce wrote:
>
>> david@lang.hm wrote:
>>> On Thu, 28 Aug 2008, Shawn O. Pearce wrote:
>>>>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>>>
>>>> Yes, I really did mean for this part of the protocol to be in binary.
>>>
>>> except that HTTP cannot transport binary data, if you feed it binary data
>>> it then encodes it into 7-bit safe forms for transport.
>>
>> So then how does it transport a GIF file to my browser?  uuencoded?
>
> something like that. it uses the mimetype mechanisms to identify the  
> various pieces and encodes each piece (if nothing else it needs to make  
> sure that the mimetype seperators don't appear in the data) uuencode is  
> one of the available mechanisms.
>
>> Last time I read the RFCs I was pretty certain HTTP is 8-bit clean
>> in both directions.
>
> I could be wrong, but I'm pretty sure I'm not. to test this yourself find 
> a webserver with an image file and retrieve it via telnet (telnet 
> hostname 80<enter>GET /path/to/file HTTP/1.0<enter><enter>) and what will 
> come back will be text.

No it won't. Try it *yourself*.

$ nc www.google.com 80 | sed '1,/^\r$/d' > /tmp/logo.gif
GET /intl/en_ALL/images/logo.gif HTTP/1.1
Host: www.google.com
Connection: close

$ file /tmp/logo.gif 
/tmp/logo.gif: GIF image data, version 89a, 276 x 110

Mike

PS: sed only removes the HTTP response headers.
