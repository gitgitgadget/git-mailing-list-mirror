From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Mon, 20 Apr 2015 10:19:21 +0100
Message-ID: <20150420091920.GA31279@hashpling.org>
References: <552E9816.6040502@gmail.com>
 <1429117174-4968-1-git-send-email-karthik.188@gmail.com>
 <20150419002807.GA11634@hashpling.org>
 <xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com>
 <20150420074433.GA30422@hashpling.org>
 <8CBC4DEB-EC50-4DD7-A687-443AA93A96A8@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 11:19:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk7rY-0001bz-0A
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 11:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbbDTJTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 05:19:25 -0400
Received: from avasout06.plus.net ([212.159.14.18]:52285 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbbDTJTX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 05:19:23 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id J9KM1q0012iA9hg019KN98; Mon, 20 Apr 2015 10:19:22 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqHQ3DCd c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=e9J7MTPGsLIA:10 a=rd59RTowd6kKLsWNT5kA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1Yk7rN-00089h-4n; Mon, 20 Apr 2015 10:19:21 +0100
Content-Disposition: inline
In-Reply-To: <8CBC4DEB-EC50-4DD7-A687-443AA93A96A8@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267461>

On Mon, Apr 20, 2015 at 02:27:44PM +0530, Karthik Nayak wrote:
> Sorry, but I didn't get you, broken objects created using hash-object --literally do not work with cat-file without the --literally option.

Perhaps an example would help:

I cannot create a bad tree without --literally:

$ echo total garbage | ./git hash-object -t tree --stdin -w
fatal: corrupt tree file
$ echo total garbage | ./git hash-object -t tree --stdin -w --literally
fa2905d47028d00baec739f6d73540bb2a75c6f7

but I can use cat-file without --literally to query the contents and
information about the object as it stands.

$ ./git cat-file tree fa2905d47028d00baec739f6d73540bb2a75c6f7
total garbage
$ ./git cat-file -t fa2905d47028d00baec739f6d73540bb2a75c6f7
tree
$ ./git cat-file -s fa2905d47028d00baec739f6d73540bb2a75c6f7
14

As far as I could tell - and please correct me if I've misunderstood,
cat-file's literally is about dealing with unrecognized types whereas
hash-object's --literally is about both creating objects with bad types
and invalid objects of "recognized" types. This latter scenario is where
the option name "literally" makes the most sense.

Charles.
