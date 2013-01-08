From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: forbid --bare --separate-git-dir <dir>
Date: Tue, 08 Jan 2013 09:45:06 -0800
Message-ID: <7v4nirfu1p.fsf@alter.siamese.dyndns.org>
References: <20130106091642.GA10956@elie.Belkin>
 <1357465670-32766-1-git-send-email-pclouds@gmail.com>
 <20130106101948.GD10956@elie.Belkin> <20130108141650.GA18637@lanh>
 <50EC543D.5090100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:45:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsdEy-0001Gi-OH
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 18:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756798Ab3AHRpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 12:45:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50695 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756485Ab3AHRpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 12:45:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED4BFAB9D;
	Tue,  8 Jan 2013 12:45:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CG3cX0/ZJR92yExAH/6LVbgVmLM=; b=HTttpu
	ZrGYF+C9ZMtNuGSVMX4bAnc6c0Ndic8nPjUYkVCacGq4RO85oeAhI1S8zzRoQb4l
	FCB09JPAVp7Aga0G1juaVWX4MmN8Jmylf8wvSwcQX43FstecKkU5PSp3T7ul1Gwr
	FWBTXQImdE2iCcOlxd5rO3Vvro9twsIBkYku4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yWYk0lXXh/IhgXlwYveXJZfRENa0ypAR
	83UVqn6GO8mQ1G9SuR6dI8NFM7rj/HcEZsy8MHo83meoY19D269PH2tHNXmNl6gH
	+VaYlWaEEqMG9FieXCfYiRSbkTD/QKQmZFnQiEG6eVxM8bL0fcUEH5CATDmHotXl
	UCgbVBsyX4Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0112AB9B;
	Tue,  8 Jan 2013 12:45:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 555ADAB9A; Tue,  8 Jan 2013
 12:45:08 -0500 (EST)
In-Reply-To: <50EC543D.5090100@web.de> (Jens Lehmann's message of "Tue, 08
 Jan 2013 18:15:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24AE067E-59BB-11E2-9DD3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212983>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 08.01.2013 15:16, schrieb Duy Nguyen:
>> On Sun, Jan 06, 2013 at 02:19:48AM -0800, Jonathan Nieder wrote:
>>> 	Unfortunately we forgot to forbid the --bare
>>> 	--separate-git-dir combination.  In practice, we know no one
>>> 	could be using --bare with --separate-git-dir because it is
>>> 	broken in the following way: <explanation here>.  So it is
>>> 	safe to make good on our mistake and forbid the combination,
>>> 	making the command easier to explain.
>>>
>>> I don't know what would go in the <explanation here> blank above,
>>> though.  Is it possible that some people are relying on this option
>>> combination?
>> 
>> I can't say it's broken in what way. Maybe it's easier to just support
>> this case, it's not much work anyway. Jens, maybe squash this to your
>> original patch?
>
> I'd be fine with that, though my gut feeling is that this should
> be a patch of its own (My patch handles the git dir, your's handles
> a work tree issue).

I agree that these are totally unrelated issues.

After all, Jonathan's suggestion to forbid it was because the
combination does not make sense and does not have practical uses,
and forbidding it would make the command easier to explain than
leaving it accepted from the command line.  If you choose to go in
the opposite direction and make "clone --bare --separate-git-dir" do
something useful, it should be explained very well in the
documentation part of the patch why such a combination is a good
idea, and in what situation the behaviour is useful and the user may
want to consider using it, I think.
