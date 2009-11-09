From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/12] Allow helper to map private ref names into 
 normal names
Date: Mon, 09 Nov 2009 08:44:24 -0800
Message-ID: <7vhbt3y7fb.fsf@alter.siamese.dyndns.org>
References: <1257547966-14603-1-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-3-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-4-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-5-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-6-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-7-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-8-git-send-email-srabbelier@gmail.com>
 <1257547966-14603-9-git-send-email-srabbelier@gmail.com>
 <alpine.LNX.2.00.0911061755360.14365@iabervon.org>
 <fabb9a1e0911061519j6d64ff50v9b0cefe61965fbbc@mail.gmail.com>
 <fabb9a1e0911082242k5950d780i584a4714e384e007@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 17:44:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7XMD-0005jh-4k
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 17:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbZKIQoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 11:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbZKIQod
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 11:44:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbZKIQod (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 11:44:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04D107AAA5;
	Mon,  9 Nov 2009 11:44:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PztPbqK03H24F7W/fcsztEXanag=; b=D/KKNj
	/Ko2HsAI0DDB49VZHzWlf9xhMiCp+pwcw/Yy8TO1tnm7OE8vV/dhJpKHK2yyZcmp
	aCmbwNmd02GrIu4kIuL+uwIGKhSRlm9i4u5Q1DU4qYiRw2k1Ou2dCYYpYpsTV8oi
	tWDvLKesvjOyVV9AU3x7T3KbvojzzRq+TV+j4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GAERlT85DK047ksDr3H7dOZqOhAQRaJX
	0oWNkubDuGQHPH5KlZsyyS+OEhv4KcdVMrEUDBv+k0s9g/eew7qYbzbcjW4U1mwp
	I2u9w4UXSlNAg+MlRi+B+zD1yN1prNoPK2oxOE8nXfeHhOQbZo+ZD1xjAmU9U8VS
	4grN7xnlD/4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B2EC27AA9B;
	Mon,  9 Nov 2009 11:44:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A94687AA96; Mon,  9 Nov
 2009 11:44:26 -0500 (EST)
In-Reply-To: <fabb9a1e0911082242k5950d780i584a4714e384e007@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 9 Nov 2009 07\:42\:43 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2820BD0C-CD4F-11DE-BCB3-7B3EEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132493>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Heya,
>
> On Sat, Nov 7, 2009 at 00:19, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> On Sat, Nov 7, 2009 at 00:12, Daniel Barkalow <barkalow@iabervon.org> wrote:
>>> At the very least, it needs documentation and memory leaks fixed (the
>>> refspec strings read from the helper, and the refspec structs and array on
>>> freeing the helper data).
>>
>> Please send follow-ups against [0] and I will include them in the next round :).
>
> It's in next now, so please send follow-ups against sr/vcs-helper.

Do you mean 'pu' or 'next'?
