From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH/RFC] Fix some warnings (on cygwin) to allow -Werror
Date: Tue, 08 Jul 2008 23:21:22 +0100
Message-ID: <4873E862.5070501@ramsay1.demon.co.uk>
References: <486CF5A9.5060104@ramsay1.demon.co.uk> <7vskuquisp.fsf@gitster.siamese.dyndns.org> <486FDB2F.3050800@ramsay1.demon.co.uk> <7vhcb3rfro.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 19:41:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGdf0-00044S-U3
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 19:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbYGIRkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 13:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbYGIRkA
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 13:40:00 -0400
Received: from anchor-post-37.mail.demon.net ([194.217.242.87]:61968 "EHLO
	anchor-post-37.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750885AbYGIRj7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jul 2008 13:39:59 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-37.mail.demon.net with esmtp (Exim 4.68)
	id 1KGde2-0001Yc-N0; Wed, 09 Jul 2008 17:39:58 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vhcb3rfro.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87897>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> Junio C Hamano wrote:
>> ...
>>>> @@ -1718,7 +1720,8 @@ static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, vo
>>>>  static void prepare_pack(int window, int depth)
>>>>  {
>>>>  	struct object_entry **delta_list;
>>>> -	uint32_t i, n, nr_deltas;
>>>> +	uint32_t i, nr_deltas;
>>>> +	unsigned n;
>>> Hmm.  Is this change necessary?
>> Yes, otherwise:
>>
>> builtin-pack-objects.c: In function `prepare_pack':
>> builtin-pack-objects.c:1760: warning: passing arg 2 of `find_deltas' from incompatible pointer type
>> make: *** [builtin-pack-objects.o] Error 1
>>
>> Note that ll_find_deltas() is #defined to find_deltas() in the #else arm
>> of #ifdef THREADED_DELTA_SEARCH, and find_deltas() takes an "unsigned *"
> 
> Ah, I missed that.  So it is not just warning squelch but is a bugfix in
> case unsigned and uint32_t are of different sizes.
> 

Yes, but I didn't think about that when I "fixed" it ;-)

ATB,

Ramsay Jones
