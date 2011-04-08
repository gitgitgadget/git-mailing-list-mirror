From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] magic pathspec: add tentative
 ":/path/from/top/level" pathspec support
Date: Fri, 08 Apr 2011 08:05:48 -0700
Message-ID: <7vtye84wc3.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-2-git-send-email-gitster@pobox.com>
 <BANLkTint7sGCg7_seu1-SWJC=_sKF-FKYw@mail.gmail.com>
 <7vd3kyf327.fsf@alter.siamese.dyndns.org>
 <BANLkTi=YK-4TOxoD1qR8TO4SymLK6sPnQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 17:06:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8DG7-0000uU-Cu
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 17:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757387Ab1DHPF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 11:05:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757204Ab1DHPF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 11:05:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3BDB14575;
	Fri,  8 Apr 2011 11:07:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rjyjta4gTX5o55wSrmEjnqdv9x0=; b=TrPf5r
	+GNuns+w5ADWgimjjVsquxOBV7i3Mc8snaiWTwpiScmJwmQe+9YAAPqUmMm5RHaM
	PMc0FGfWCfvtMfEP0ikxlRZe3YkOkYUNB8CGqDdQZ5b8HMw4067zvNR1oZXoOAok
	geY/KM42+uAgqEMCFSsZY/3pYoKqhCvS1XHFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LFxlnZ8Vtjnnxq39sS0G1mhA1nLL55Er
	+Z/w7lWm6ixcyPtCDputMDq6z2Ik2Rd632L+40YrGbprOmXKCyUFN47ECa/ejG4U
	Cx/RDAgoz3swgGERD3CN2FufDeizJpWguWOXNSfrYKxlNHBwAvxxrU6A/FCE0l4s
	DILEmKl7f3Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15DB44574;
	Fri,  8 Apr 2011 11:07:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 30F194570; Fri,  8 Apr 2011
 11:07:45 -0400 (EDT)
In-Reply-To: <BANLkTi=YK-4TOxoD1qR8TO4SymLK6sPnQA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Fri, 8 Apr 2011 19:00:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F79823DA-61F1-11E0-81E7-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171130>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Apr 7, 2011 at 11:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> This is so that you can say ":/.gitignore" and do not have to say
>> ":/:.gitignore".
>
> But then, say people have a file named @foo at top dir. They can write
> ":/@foo" to address the file. Some time later we decide to use '@' as
> magic, how can we re-train user's fingers?

You don't.  The primary goal of short form is to be short to type from the
command line, and if you are in doubt, you can always disambiguate by
saying ":/:@foo", and you can use the terminating colon even if you are
sure "@" is not a magic in your version of git.

Scripts can and should use the long form for readability and compatibility.

> Although I quite like it, one less keystroke for me.

Exactly.  It is Ok if the short form is a bit more complex to explain than
the long form (which should be very easy to explain).  The goal of the
short form is to make the end result is short to type, once the user
understands the rules.
