From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] replace: add --graft option
Date: Mon, 19 May 2014 11:42:07 +0200
Message-ID: <5379D1EF.8040203@alum.mit.edu>
References: <20140518182939.5260.91202.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 11:42:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmK5I-0000OV-HY
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 11:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbaESJmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 05:42:13 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42416 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750803AbaESJmM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 May 2014 05:42:12 -0400
X-AuditID: 1207440e-f79026d000000c25-77-5379d1f3493c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.35.03109.3F1D9735; Mon, 19 May 2014 05:42:11 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0FFE.dip0.t-ipconnect.de [93.219.15.254])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4J9g7IU030083
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 19 May 2014 05:42:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <20140518182939.5260.91202.chriscool@tuxfamily.org>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqPv5YmWwwZ/DzBabnk9ktui60s1k
	0dB7hdniR0sPswOLx7PePYweFy8peyx/8Ird4/MmuQCWKG6bpMSSsuDM9Dx9uwTujHW3F7EU
	zOWq2DIroIFxCkcXIyeHhICJxNTDPawQtpjEhXvr2boYuTiEBC4zSnSeeccC4Zxnkvj+eg4T
	SBWvgLbE5vv/gBIcHCwCqhKTX7iDhNkEdCUW9TQzgYRFBYIk/pxVhKgWlDg58wkLiC0iEC0x
	/dIUdhCbWcBIYuaaH4wgtjDQDSt7voLZQgL2Epv/PQSr4RRwkFjcdxlsk4SAuERPYxBEq47E
	u74HzBC2vMT2t3OYJzAKzkKybRaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXW
	y80s0UtNKd3ECAlwvh2M7etlDjEKcDAq8fC+iKwMFmJNLCuuzD3EKMnBpCTKu/YCUIgvKT+l
	MiOxOCO+qDQntfgQowQHs5IIr99poBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFq
	EUxWhoNDSYL3L8hQwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFDsxhcDoxckxQO0
	l+EiyN7igsRcoChE6ylGXY5Td461MQmx5OXnpUqJ84aD7BAAKcoozYNbAUtnrxjFgT4W5uUF
	GcUDTIVwk14BLWECWvJ3MdiSkkSElFQD49pz+WVxsiuk+E9ttjy3taolTox9RVrfiqSLpk8n
	F+re+Lhq7/dr7rwrLWOOv9X+neb94GO1VJY219u05I3f2DgvnLsmvG+e0gbLv1Gr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249569>

On 05/18/2014 08:29 PM, Christian Couder wrote:
> The usage string for this option is:
> 
> git replace [-f] --graft <commit> [<parent>...]
> 
> First we create a new commit that is the same as <commit>
> except that its parents are [<parents>...]
> 
> Then we create a replace ref that replace <commit> with
> the commit we just created.
> 
> With this new option, it should be straightforward to
> convert grafts to replace refs, with something like:
> 
> cat .git/info/grafts | while read line
> do git replace --graft $line; done

I love the functionality; I think it's a great step towards making
grafts obsolete.

I haven't worked with Git's object reading/writing code much, but it
surprised me that you are editing the commit object basically as a
string, using hard-coded length constants and stuff.  It seems
error-prone, and we already have a commit parser.

Would it be possible to program this at a higher layer of abstraction
based on the commit object produced by the existing commit parser?
E.g., edit the object it produces, and write the result?  Or create a
new commit object out of the parsed commit object and write that?

It's great that you're working on this!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
