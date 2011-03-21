From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Mon, 21 Mar 2011 10:01:53 +0100
Message-ID: <4D871401.6020900@drmicha.warpmail.net>
References: <cover.1300459016.git.git@drmicha.warpmail.net> <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net> <20110318194802.GB27825@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 10:02:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1azw-00039h-6g
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 10:02:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288Ab1CUJBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 05:01:55 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60714 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751642Ab1CUJBy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 05:01:54 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 81C0F20151;
	Mon, 21 Mar 2011 05:01:53 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 21 Mar 2011 05:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Kyw4uMvfZ6u86PSfJw8TOs2vCFs=; b=FpiEnkVnPShqGyeLqEs7RQ5awRkSBfcRioD6FM6bgCRb3LgfxKkyw/1hrbfzm5sDJaeoGAYlnVQySu3JVmfOWVWfYpsAFCXp4JXGSYiaGKjjF/lPQxIEpVHp3LIRaB7O2Mon3PHvHmvd7pq7s8cf5QGwkIUu4dla8uy6D2uWoAw=
X-Sasl-enc: Po43uCLhtfA+2KwaO70uas8MAJnKKdw0pu+mEmaugsjP 1300698113
Received: from localhost.localdomain (p548593A3.dip0.t-ipconnect.de [84.133.147.163])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B38FE446AA9;
	Mon, 21 Mar 2011 05:01:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <20110318194802.GB27825@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169562>

(Working my way backwards through the responses.)

Jeff King venit, vidit, dixit 18.03.2011 20:48:
> On Fri, Mar 18, 2011 at 03:50:25PM +0100, Michael J Gruber wrote:
> 
>> +--min-parents::
>> +--max-parents::
>> +
>> +	Show only commits which have at least resp. at most that many
>> +	commits, where `--max-parents=8` denotes infinity (i.e. no upper
>> +	limit). In fact, 7 (or any negative number) does, but 8 is
>> +	infinity sideways 8-)
> 
> I didn't quite parse this "resp." in the middle.

Well, there are two options (--min-parents, --max-parents) which we
describe in one paragraph. Sooo...

> 
>> ++
>> +In particular, `--max-parents=1` is `--no-merges`, `--min-parents=2` is
>> +`--merges` (only), `--max-parents=0` gives all root commits and
>> +`--min-parents=3` all octopusses.
> 
> Spelling nit: the plural of octopus is "octopuses" (or "octopi" or
> "octopodes", depending on which dictionary you consult).
> 
> I think it's good to equate --{no-,}merges with their
> --{max,min}-parents counterparts here. We should probably do the same
> for the reverse association, like:
> 
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index fcc4c6c..f32509a 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -226,11 +226,13 @@ endif::git-rev-list[]
>  
>  --merges::
>  
> -	Print only merge commits.
> +	Print only merge commits. This is equivalent to
> +	`--min-parents=2`.
>  
>  --no-merges::
>  
> -	Do not print commits with more than one parent.
> +	Do not print commits with more than one parent. This is
> +	equivalent to `--max-parents=1`.
>  
>  --min-parents::
>  --max-parents::
> 
> That way it is obvious that "--merges" cancels a previous --min-parents
> on the command line (maybe the text should be "this is an alias for..."
> to make it clear that doing it is exactly the same).

Yes, that is helpful. I have doubts about "alias" for. Without wanting
to sound elitist or something, I have the impression that we start
catering for users who understand "equivalent" more reliably than "alias".

> This provides a user-friendly form for the two common cases. Do we care
> about the other cases, or adding a single multi-state flag like
> --show-parents={all,merges,etc}? They other ones are rare enough and

I know that name is not a serious suggestion...

> particular enough that it is probably fine for people to just use
> {min,max}-parents directly. So I would say what you have is good.

Thanks :)

I would go for something multi-state like only If I were allowed to
stamp on the existing --merges/--no-merges, which I am not. ;)

Michael
