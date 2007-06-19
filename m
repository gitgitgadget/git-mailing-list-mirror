From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] config: Add --null/-z option for null-delimted output
Date: Tue, 19 Jun 2007 13:50:34 +0200
Message-ID: <200706191350.34714.jnareb@gmail.com>
References: <f2t6na$5bi$1@sea.gmane.org> <20070619021252.GE19725@planck.djpig.de> <Pine.LNX.4.64.0706191208300.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Tue Jun 19 18:03:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0gBA-0002qU-C1
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 18:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788AbXFSQDj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 12:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756775AbXFSQDj
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 12:03:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:19925 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510AbXFSQDi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 12:03:38 -0400
Received: by ug-out-1314.google.com with SMTP id j3so137734ugf
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 09:03:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=B3d8XcfUb9foPzUxNni+jn03FBZud+RfagqrCQMH8nuds98d61BJxeRy2vlbn3R8C6Htgd6YD3xIEd33EGd+VolchSonkN3ABH3CMFCnEYofj5kH/0TbgMU38EI6epYfXhkcC6mCLnW+q812exg7l8T6GJXDwHj2uVQr5DnuUx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=n+KbMakqrZomoUKE+oxRTzRm7qIKuhJg+IVYM0gJcIMUaUAMtrTksIpGozZTIRImwXcmkzadgpnQ6rHchF9QxbQyPtd9ZsGWGhvmbZb/yr/y/qrzWXpJIlr9XCxdxjtox12iSi366RqZCLK2BGx5d5DB1feeC8Km4oHtU94zbaM=
Received: by 10.82.175.17 with SMTP id x17mr13948433bue.1182269016262;
        Tue, 19 Jun 2007 09:03:36 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id g1sm5470135muf.2007.06.19.09.03.33
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jun 2007 09:03:34 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0706191208300.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50492>

Johannes Schindelin wrote:
> On Tue, 19 Jun 2007, Frank Lichtenheld wrote:
>> On Mon, Jun 18, 2007 at 06:37:35PM -0700, Junio C Hamano wrote:

>>> Another possibility, though, is to say:
>>> 
>>> 	core.some\0where\0core.over\0\0core.the\0core.rainbow\0
>> 
>> How do you denote empty values then?
>> 
>> [section]
>> 	key=
>> 	key
>> 
>> this are two very different statements atm (e.g. the one is false and
>> the other one is true).
>> 
>> I still think using two different delimiters is the simplest choice.
> 
> Okay, good point. But of course, you have to use a delimiter for the key 
> name that cannot be part of the keyname. You picked '\n'. The original was 
> '='. Both work.

If I remember correctly (and what I checked to be true), while '=' cannot
be part of keyname nor section name, it can be part of subsection name,
therefore it can be part of fuly qualified key name.

The '\n' can _not_ be part of subsection name, therefore it can not be
part of fully qualified key name.

  $ cat > conftest <<EOF
  [section "sub=section"]
       truekey=true
       emptykey=
       novalkey
  EOF

  $ GIT_CONFIG=conftest git-config -l
  section.sub=section.truekey=true
  section.sub=section.emptykey=
  section.sub=section.novalkey

-- 
Jakub Narebski
Poland
