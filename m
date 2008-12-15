From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: "git gc" doesn't seem to remove loose objects any more
Date: Mon, 15 Dec 2008 17:59:44 +0100
Message-ID: <237967ef0812150859g2c506820y740a25be194e9754@mail.gmail.com>
References: <808wqhzjl9.fsf@tiny.isode.net>
	 <237967ef0812150538n671c22b8gaf7a7b5dcaf68433@mail.gmail.com>
	 <20081215140834.GA3684@atjola.homenet>
	 <20081215155610.GA11502@mit.edu>
	 <20081215161212.GE31145@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Theodore Tso" <tytso@mit.edu>,
	"Bj?rn Steinbrink" <B.Steinbrink@gmx.de>,
	"Bruce Stephens" <bruce.stephens@isode.com>, git@vger.kernel.org
To: "Mark Brown" <broonie@sirena.org.uk>
X-From: git-owner@vger.kernel.org Mon Dec 15 18:01:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCGob-0003Cp-HQ
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 18:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbYLOQ7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 11:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbYLOQ7r
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 11:59:47 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:34396 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbYLOQ7r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 11:59:47 -0500
Received: by nf-out-0910.google.com with SMTP id d3so467250nfc.21
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 08:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=I/TKJgXlIO75TNNZkf1mUAnYk81lMLBYmyBsNF4Gxno=;
        b=mxutWfVHEaNeBDmfsD5FrTxeM7uMYqAKyzLX6Qj5z7ekxidIEFORMXTIK5J+jHYafc
         KSTrlcmp8NTVPHzH15MckjKwkj9wJrKnHTfWS7X8ODuFjBxLxJ7f/nbLq85w6B1ZWBjJ
         7URx2p3N8TSdt00lqP1yY2HA4sNVaO/cuGwa8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ig515qciBOakoScdsty7HlzT11OVycHHIcm6EFSV2vQ2gKBKI5s3PQKpyJ8fRyB69z
         ENW0MFycJAXVy0QAtBFzBDz/tRh169bwqe9ofPrPJXEgr5BQQlp/hic1C2VDIJiNPmV7
         5m5x75FXCXDMYD+oCqxtrxPibFaeDw7Zl4TnY=
Received: by 10.210.130.14 with SMTP id c14mr2608856ebd.32.1229360385005;
        Mon, 15 Dec 2008 08:59:45 -0800 (PST)
Received: by 10.210.82.6 with HTTP; Mon, 15 Dec 2008 08:59:44 -0800 (PST)
In-Reply-To: <20081215161212.GE31145@sirena.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103182>

2008/12/15 Mark Brown <broonie@sirena.org.uk>:
> On Mon, Dec 15, 2008 at 10:56:10AM -0500, Theodore Tso wrote:
>> On Mon, Dec 15, 2008 at 03:08:34PM +0100, Bj?rn Steinbrink wrote:
>
>> > To clarify that a bit more: git gc keeps unreachable objects unpacked,
>> > so that git prune can drop them. And git gc invokes git prune so that
>> > only unreachable objects older than 2 weeks are dropped.
>
>> To be even more explicit, "git gc" will **unpack** objects that have
>> become unreachable and were currently in packs.  As a result, the
>> amount of disk space used by a git repository can actually go **up**
>> dramatically after a "git gc" operation, which could be surprising for
>> someone who is running close to full on their filesystem, deletes a
>> number of branches from a tracking repository, and then does a "git
>> gc" may get a very unpleasant surprise.
>
> It can also cause things like the "please repack" warning in git gui to
> go off.  This is especially unhelpful since they tend to tell you to go
> and do a gc to resolve the problem.

A thought that occurs to me is to add some sort of flag to git count-objects
that prints the number of objects older than some interval in a separate field.
That way git gui would give less (maybe no) false alarms.

-- 
Mikael Magnusson
