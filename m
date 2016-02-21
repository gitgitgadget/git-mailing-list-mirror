From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH 1/5] bisect: read bisect paths with strbuf_getline()
Date: Mon, 22 Feb 2016 00:48:54 +0100
Message-ID: <56CA4CE6.9070802@moritzneeb.de>
References: <56ACF82B.2030005@moritzneeb.de> <56ACFB03.3020000@moritzneeb.de>
 <xmqqlh74unja.fsf@gitster.mtv.corp.google.com> <56C0EB3F.90202@moritzneeb.de>
 <xmqqtwlar2bd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 02:24:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXfE9-0005x6-Aa
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 02:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbcBVBXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 20:23:47 -0500
Received: from moritzneeb.de ([78.47.1.106]:55724 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbcBVBXr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 20:23:47 -0500
Received: from [192.168.1.3] (x55b377aa.dyn.telefonica.de [85.179.119.170])
	by moritzneeb.de (Postfix) with ESMTPSA id E64DB1C05B;
	Mon, 22 Feb 2016 02:23:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456104223;
	bh=ckOSDHYh7VH3u/97bwg6kXi+6lipSkbjeAUJmFbXg98=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
	b=Toq9viN3kF9Ft9bf9Ah7jBnSia1ENeSOGdzL8FOvNV3Q9niTnyCI89gtm5R9U46tw
	 6SDd7Qveq72t6IrXan/g+KXrSrHdrX7n3A3SnjCdlFfYp4ITL/jyQ4MQF0vLl67aj7
	 Cbq9r/fedgIIzKXuNj9Jnhb5oAjVXkVRst9fNbEw=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqqtwlar2bd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286861>

On 02/15/2016 06:05 AM, Junio C Hamano wrote:
> Moritz Neeb <lists@moritzneeb.de> writes:
> 
>>> You would also want to think about the necessity of strbuf_trim()
>>> here.  Now strbuf_getline() would trim the trailing CR, would we
>>> still need to call strbuf_trim() here?  The code will break if you
>>> just remove the call, but on the other hand, you will realize that
>>> the trimming done by calling it is excessive and unnecessary, once
>>> you inspect the code and learn who writes the file being read here
>>> and how.
>>
>> I am not sure what you mean by excessive: How much can I assume that
>> the input is like expected? The files we are talking about are supposed
>> to be read and written by git only. But could be modified in theory with
>> an editor, right? Then things could break, right? This question maybe holds
>> true for the other patches as well, I still have to look into them.
> 
> These are all good questions you as a Git contributor to be asking
> yourself, and I really like the fact that you are thinking aloud
> here.

Thanks for this feedback I will try to continue this thinking aloud
whenever appropriate.

Sorry by the way for only answering every week - I currently only have
time to work on git during the weekend. What is (assuming familiarity
with the codebase) the expected "cooking"-time of a smaller patch? I'm
sure the answer is "depends", but maybe you can give away some experiences.
