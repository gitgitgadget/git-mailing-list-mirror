From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] Makefile: implement help target
Date: Wed, 29 Sep 2010 10:06:05 +0200
Message-ID: <4CA2F36D.2010901@drmicha.warpmail.net>
References: <AANLkTikx2tL73gJQnqjG7yp3btcZJprKLf0z9QwcAUC1@mail.gmail.com> <4fd8b490b4badd13c0ea46408e44dc7b317dc0ed.1285706151.git.git@drmicha.warpmail.net> <r6bnW3ubJQeOuXWFRPisJu1hXBq3kXeHCvNe10M00ZM@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Sep 29 10:06:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0rfv-00037s-Un
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 10:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab0I2IF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 04:05:58 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:37941 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750938Ab0I2IF4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 04:05:56 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4C12D516;
	Wed, 29 Sep 2010 04:05:55 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 29 Sep 2010 04:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=hbjhkaCCY8JO2+2F5lhsDQqGUNE=; b=o7P/BJsyPPRiLmZAzUdfg4psNbg9Du51sw3ScJ35Y8w2lOhUxgbPKsrPyy8qJ4noJ08eJuKxmFy3vuhrxtfy8S8JywGAuZxQCwn3B/RwxrPM40RWGiSyzoD6o1exQCYJuY9gy0bWpGYoXhdckKcVbkGkCsN+6bR1F2MPRQMlGiM=
X-Sasl-enc: HOyf/JWdIvgDWJ9AvbenwUP5dYWYbFT/auebwMlTA5k3 1285747555
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 26D985E1726;
	Wed, 29 Sep 2010 04:05:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <r6bnW3ubJQeOuXWFRPisJu1hXBq3kXeHCvNe10M00ZM@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157543>

Brandon Casey venit, vidit, dixit 29.09.2010 00:00:
> On 09/28/2010 03:38 PM, Michael J Gruber wrote:
>> with automatic help text collection from lines starting with "# Help: " and
>> preceding a make target.
>>
>> Suggested-by: Stephen Boyd <bebarino@gmail.com>
>> Helped-by: Andreas Ericsson <andreas.ericsson@op5.se>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> Now how's this for portability and such? New output:
>>
>> Build targets:
>>     all:                Build the Git suite
>>     dist:               Build git-$(GIT_VERSION).tar.gz source
>>     dist-doc:           Build $(manpages).tar.gz and $(htmldocs).tar.gz
> <snip>
> 
>>  Makefile |   43 +++++++++++++++++++++++++++++++++++++++++--
>>  1 files changed, 41 insertions(+), 2 deletions(-)
> 
> 
> Very nice.  Too bad we have more targets than fit in my 33-line terminal.
> 
> /bikeshed
> 
> How about this micro-tweak:
> 
>   1) Remove the colon from the targets so they sort correctly.
>      i.e. so "dist" sorts before "dist-doc" and "install" sorts
>           before "install-*"
>   2) Add " - " prefix to description strings and reduce target
>      width accordingly so we still have just as much room for
>      the description string.
> 
> So the output looks like this:
> 
....
> Install targets:
>     install            - Install the Git suite
>     install-doc        - Install man pages
>     install-html       - Install HTML docs
>     install-info       - Install info docs
>     install-man        - Install man pages
>     install-pdf        - Install PDF docs
>     quick-install-doc  - Install pregenerated man pages from origin/man
>     quick-install-html - Install pregenerated HTML pages from origin/html
>     quick-install-man  - Install pregenerated man pages from origin/man

Sounds good, although the sort order depends on the locale. "LANG=C
sort" takes care of that.

> Oh, by the way, tested and works on Solaris 10 and IRIX 6.5.

Thanks!
Michael
