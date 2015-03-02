From: Sam Vilain <sam@vilain.net>
Subject: Re: weaning distributions off tarballs: extended verification of
 git tags
Date: Mon, 02 Mar 2015 11:38:00 -0800
Message-ID: <54F4BC18.5060702@vilain.net>
References: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com> <CANv4PNmF9sTh8od9xT5tYTOF1Cv0Mev2Muf-qxQDS_6kE7EnOw@mail.gmail.com> <1425316197.895196.234425829.536E6C06@webmail.messagingengine.com> <20150302181230.GA31798@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Joey Hess <id@joeyh.name>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 20:43:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSWFw-0002Wu-C1
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 20:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755404AbbCBTnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 14:43:49 -0500
Received: from tx.vilain.net ([74.50.57.245]:55750 "EHLO tx.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755018AbbCBTnr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 14:43:47 -0500
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2015 14:43:47 EST
Received: from [10.133.246.91] (unknown [38.104.194.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by tx.vilain.net (Postfix) with ESMTPSA id C26D88407;
	Mon,  2 Mar 2015 19:38:01 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <20150302181230.GA31798@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264614>

On 03/02/2015 10:12 AM, Joey Hess wrote:
> I support this proposal, as someone who no longer releases tarballs
> of my software, when I can possibly avoid it. I have worried about
> signed tags / commits only being a SHA1 break away from useless.
>
> As to the implementation, checksumming the collection of raw objects is
> certainly superior to tar. Colin had suggested sorting the objects by
> checksum, but I don't think that is necessary. Just stream the commit
> object, then its tree object, followed by the content of each object
> listed in the tree, recursing into subtrees as necessary. That will be a
> stable stream for a given commit, or tree.

I would really just do it exactly the same way that git does: checksum 
the objects including their headers with the new hashes.  I have a hazy 
recollection of what it would take to replace SHA-1 in git with 
something else; it should be possible (though tricky) to do it lazily, 
where a tree entry has bits (eg, some of the currently unused file mode 
bits) to denotes which hash algorithm is in use for the entry.  However 
I don't think that got past idea stage...

Sam
