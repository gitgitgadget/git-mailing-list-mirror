From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v7 4/5] pretty: Add failing tests: --format output should
 honor logOutputEncoding
Date: Tue, 02 Jul 2013 09:22:09 +0200
Message-ID: <51D27FA1.9040600@viscovery.net>
References: <cover.1372240998.git.Alex.Crezoff@gmail.com> <9e83de68067be7548c0119d6e99caa905fab0c0f.1372240999.git.Alex.Crezoff@gmail.com> <51D12927.5050000@viscovery.net> <20130701225013.GA17377@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 09:22:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utuut-00075i-Kr
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 09:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392Ab3GBHWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 03:22:19 -0400
Received: from so.liwest.at ([212.33.55.13]:56548 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932219Ab3GBHWS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 03:22:18 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Utuuk-0000Y7-Bh; Tue, 02 Jul 2013 09:22:14 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8327B1660F;
	Tue,  2 Jul 2013 09:22:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130701225013.GA17377@ashu.dyn1.rarus.ru>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229370>

Am 7/2/2013 0:50, schrieb Alexey Shumkin:
> On Mon, Jul 01, 2013 at 09:00:55AM +0200, Johannes Sixt wrote:
>> Am 6/26/2013 12:19, schrieb Alexey Shumkin:
>>>  test_expect_success 'setup complex body' '
>>>  	git config i18n.commitencoding iso8859-1 &&
>>>  	echo change2 >foo && git commit -a -F commit-msg &&
>>>  	head3=$(git rev-parse --verify HEAD) &&
>>> -	head3_short=$(git rev-parse --short $head3)
>>> +	head3_short=$(git rev-parse --short $head3) &&
>>> +	# unset commit encoding config
>>> +	# otherwise %e does not print encoding value
>>> +	# and following test fails
>>
>> I don't understand this comment. The test vector below already shows that
>> an encoding is printed. Why would this suddenly be different with the
>> updated tests?
> I've changed tests. I've reverted back these ones, and added
> new ones with no i18n.commitEncoding set
>>
>> Assuming that this change doesn't sweep a deeper problem under the rug,
>> it's better to use test_config a few lines earlier.
>>
>>> +	git config --unset i18n.commitEncoding
>>> +
>>>  '
>>>  
>>>  test_format complex-encoding %e <<EOF
>>>  commit $head3
>>>  iso8859-1
>>
>> This is the encoding that I mean.
> These encodings "have appeared" because we've changed 'setup':
> we make commits with i18n.commitEncoding set

I understand why there are additional encoding entries in the expected
output, but we see one encoding entry already listed without this patch.
Why do you say "does not print encoding value" in the comment above?

>>
>>>  commit $head2
>>> +iso-8859-1
>>>  commit $head1
>>> +iso-8859-1
>>>  EOF

-- Hannes
