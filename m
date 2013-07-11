From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/7] push: document --lockref
Date: Thu, 11 Jul 2013 23:10:46 +0200
Message-ID: <51DF1F56.9000705@kdbg.org>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <1373399610-8588-1-git-send-email-gitster@pobox.com> <1373399610-8588-8-git-send-email-gitster@pobox.com> <51DC7199.2050302@kdbg.org> <7vhag3v59o.fsf@alter.siamese.dyndns.org> <51DC78C0.9030202@kdbg.org> <7v38rnv0zt.fsf@alter.siamese.dyndns.org> <7vvc4jtjqa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 23:11:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxO8m-0004Ax-Ht
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 23:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756699Ab3GKVKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 17:10:51 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:4505 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756689Ab3GKVKu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 17:10:50 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2D681A7EB0;
	Thu, 11 Jul 2013 23:10:47 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3C5AF19F616;
	Thu, 11 Jul 2013 23:10:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vvc4jtjqa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230129>

Am 10.07.2013 01:08, schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> I _think_ I am OK if we introduced "--allow-no-ff" that means the
>> current "--force" (i.e. "rewinding is OK"), that does not defeat the
>> "--lockref" safety.  That is the intended application (you know that
>> push does not fast-forward because you rebased, but you also want to
>> make sure there is nothing you are losing by enforcing --lockref
>> safety).
>>
>> If that is what happens, then I think "--force" that means "anything
>> goes" makes sense.
> 
> Or perhaps you were implicitly assuming that "--lockref" would
> automatically mean "I know I am rewinding, so as soon as I say
> --lockref, I mean --allow-no-ff", and I did not realize that.

That's what I mean, sort of. Because of your 4 cases of a ref update, I
do not think that

> 3. The update fast-forwards, but the ref to be updated is not at the
>    expected place; or

is important to consider. The point of --lockref is to avoid data loss,
but if the push is fast-forward, there is no data loss.

> If that is the semantics you are proposing, then I think it makes
> sense to make "--force" the big red button that lets anything go.
> 
> I was considering "--lockref" to be orthogonal to the traditional
> "ff only check", and rejecting a push when the updated ref's current
> value is expected (i.e. --lockref satisfied) but the update does not
> fast-forward, and that was where my resistance to allow "--force" to
> override "--lockref" comes from (because otherwise there is no way
> to say "I know I want to bypass 'ff-only' check, but instead make
> sure the current value is this").

Again: Why not just define +refspec as the way to achieve this check?

-- Hannes
