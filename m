From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC PATCH 1/2] Replace memset(0) with static initialization
 where possible
Date: Thu, 09 Oct 2008 15:30:53 -0500
Message-ID: <OyFvwSFhjVWBmuGctgXwtQ_h6P80_eGa3xtRRd1nLTP-oCvddNO_TQ@cipher.nrlssc.navy.mil>
References: <NveF6_7LIvvEmRZEvLeTO5lw7EzzmOQkz1WGEMYGSFKDWqSwAeLwBw@cipher.nrlssc.navy.mil> <20081009191727.GY8203@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 22:32:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko2BM-00014P-6V
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 22:32:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbYJIUa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 16:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbYJIUa5
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 16:30:57 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48898 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbYJIUa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 16:30:56 -0400
Received: by mail.nrlssc.navy.mil id m99KUsUf004915; Thu, 9 Oct 2008 15:30:54 -0500
In-Reply-To: <20081009191727.GY8203@spearce.org>
X-OriginalArrivalTime: 09 Oct 2008 20:30:54.0784 (UTC) FILETIME=[EDD5F400:01C92A4D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97882>

Shawn O. Pearce wrote:
> Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> Is there interest in a patch like this?
> 
> I think this is not a worthwhile change.
>  
>> "Possible" benefits:
>>
>>   1) more concise, so it improves readability in most cases
> 
> I'm not sure.
> 
> Maybe I'm just too used to reading memset(&foo, 0, sizeof(foo)),

Well, I don't have to get the sizeof(foo) part right if I use {0,}.

> but {{0},} seems very difficult to read.

It wouldn't be the first usage in the git source.

>>   2) gives compiler more flexibility when optimizing
> 
> Shouldn't a good C compiler notice something like a memset and inline
> it when possible?  They already can inline strlen on a constant.

I'm sure most of them do.

>> Drawbacks:
>>
>>   1) many lines touched for no functional change
> 
> That's a pretty big drawback.
> 
> What happens when a struct gets a struct as its first member?
> Do all the {0,} inits for it have to change to {{0,},} ?

yes, if you don't want compiler warnings.

-brandon
