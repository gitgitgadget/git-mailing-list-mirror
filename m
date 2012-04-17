From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 11:15:36 -0700
Message-ID: <7v4nsins1j.fsf@alter.siamese.dyndns.org>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
 <20120415213718.GB5813@burratino> <20120416221531.GA2299@goldbirke>
 <CAMP44s2N9wFg5kx7jw2w6G6BQ1riX-W9cKt8kBPaofugm0OV1g@mail.gmail.com>
 <7vty0inys6.fsf@alter.siamese.dyndns.org>
 <CAMP44s1sj27U_s3Y3nLL6pkMrPMVvTo982c85x-hH5szvprK0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:15:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKCwL-0001Am-1w
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 20:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab2DQSPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 14:15:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41498 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754140Ab2DQSPj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 14:15:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E6D47C8D;
	Tue, 17 Apr 2012 14:15:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k/fOi9XqJPewOMClg37DSJ33rUg=; b=roWVd1
	Op9bI1yMoDBi3J1YJecqwoPZaczHXpvY9e95rsfyfcKVqg4H6sIdRzPr5amctOq5
	uDRvNYKJ+gZrSs83D1sGd+q3tiYRiF903NX/EOVJipC6K3IbkeMOs6c10oW7+VJI
	c1O1Ac027+AI0OMXSCwaVscTF2NB0I4OrVfv4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TT39VHbZ6iu7w7JEtlvOFh1Agg7Qew8J
	CMWBoh3kylwtw9xQgOy0dSdvB2r646hpzm0xb2FvgrDt14hsHC4Za4+Fw7vAkucR
	g5cC+sSx9bZdrqi700hSHT5WpZEQ782eUl7zhG8bmcZJP/9RyESpdJ4qAtekX7fO
	idUu7JBdPO4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54AB67C8C;
	Tue, 17 Apr 2012 14:15:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D53D87C8A; Tue, 17 Apr 2012
 14:15:37 -0400 (EDT)
In-Reply-To: <CAMP44s1sj27U_s3Y3nLL6pkMrPMVvTo982c85x-hH5szvprK0g@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 17 Apr 2012 19:13:14 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5546ABF2-88B9-11E1-8774-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195781>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, Apr 17, 2012 at 6:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
> ...
>>>> And foo_wrap() should also fit into those namespaces.
>>>
>>> Yeah, I don't have a problem with that, just forgot about it.
>>>
>>> But git_complete I think is different.
>>
>> Is git_complete something the user types interactively, or is it meant to
>> be used in their .bashrc to help them complete arguments to their custom
>> scripts that take arguments similar to Git Porcelains?
>
> It's meant for their .bashrc, but can be used interactively, exactly
> like 'complete'. You can type 'complete -o bashdefault -o default -o
> nospace -F _git git' in the command like, but that would rarely
> happen.

OK, then I do not think "as a public interface it looks somewhat ugly"
(which I happen to think, and I am guessing that you agree with) matters.
It looks to me that it would be sane to follow the convention to avoid
accidental name clashes with userspace names by naming it "__git_complete"
in that case.
