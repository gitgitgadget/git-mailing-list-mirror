From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Is anyone working on a next-gen Git protocol?
Date: Wed, 10 Oct 2012 23:32:00 +0100
Organization: OPDS
Message-ID: <4CD4F3E1194047F5B91D4D4E1CE146AC@PhilipOakley>
References: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com> <5072973D.4080703@op5.se> <7vtxu5lyjr.fsf@alter.siamese.dyndns.org> <035A66D9-FAF0-48EE-B161-7D0CAD92F2FB@zib.de> <7vlifeawd5.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>, <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 00:32:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM4ot-0006fP-Uk
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 00:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351Ab2JJWbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 18:31:53 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:37142 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756906Ab2JJWbw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 18:31:52 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqsNAAf2dVBcGnKf/2dsb2JhbABEi1GyZwEBAnuBCYIbBQEBBQgBAS4eAQEhCwIDBQIBAxUMJRQBBBoGBxcGAQkJCAIBAgMBh3e4I4t2MoECg11gA4gjhUWYNIJu
X-IronPort-AV: E=Sophos;i="4.80,567,1344207600"; 
   d="scan'208";a="405879671"
Received: from host-92-26-114-159.as13285.net (HELO PhilipOakley) ([92.26.114.159])
  by out1.ip02ir2.opaltelecom.net with SMTP; 10 Oct 2012 23:31:50 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207449>

From: "Junio C Hamano" <gitster@pobox.com>
> Steffen Prohaska <prohaska@zib.de> writes:
>
>> I've recently discovered that the current protocol can be amazingly
>> inefficient when it comes to transferring binary objects.  Assuming 
>> two
>> repositories that are in sync.  After a 'git checkout --orphan && git
>> commit', a subsequent transfers sends all the blobs attached to the 
>> new
>> commit, although the other side already has all the blobs.
>
> I do not think it has anything to do with binary, but what you
> deserve from using orphan, where you declared that the history does
> not have anything to do with the original.
>
> If both of your repositories had the two paralle lines of these
> histories as branches, the transfer would have went well with or
> without binary objects.
> --
Steffen,
An alternative could be a shallow clone for just those branches with the 
binary objects, so that the git objects are still identical. Or use a 
replace/graft to trim the line of development. It's still a fudge, but 
something you could look at. 
