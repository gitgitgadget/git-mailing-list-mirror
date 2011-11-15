From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] sequencer: sequencer state is useless without todo
Date: Tue, 15 Nov 2011 08:27:04 -0800
Message-ID: <7v7h31wduv.fsf@alter.siamese.dyndns.org>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-4-git-send-email-artagnon@gmail.com>
 <20111106002645.GE27272@elie.hsd1.il.comcast.net>
 <CALkWK0nGhUshwJM1vmAUhBG9foH+=6+_KFhfTTF6+kNS0Hm2JA@mail.gmail.com>
 <7v7h33oifq.fsf@alter.siamese.dyndns.org>
 <CALkWK0nUuzn2_itdACHLQBpUaVv97tFAjNGdVBEhWC7a6Rp75w@mail.gmail.com>
 <20111115095225.GB23139@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 15 17:28:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQLrt-0000uv-Rr
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 17:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756799Ab1KOQ1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 11:27:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756540Ab1KOQ1I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 11:27:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00E8E58BB;
	Tue, 15 Nov 2011 11:27:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nkFBL35EEPr3I6Kp6I37TEg02Oo=; b=RENRf+
	RkznR7/vWQRc+QAUEQcFmYcXph5ugYfFZHhahZ3k+yo/GfX/IoTuqaSIb/gEREG3
	bCbTDI41jaz5wg/SfdFSvqhsyV7PiyZ4Eeybl398nsFANv1MjrQCwty13SScXuAM
	yPqIgC3WqoHNiaN5MIdqVNMN+f3APfFSW2SnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zcx1066o06wK/HKXd8dIuq4e3jD+xz2s
	6aTNMnNHfT2h40lTO+EZpbIz9v230tQ+5tg1kLVl2CI9gpsNKQYWKSrMZCXNj5xL
	3sfWiWotwYRqlYfR0O+creHeV8YcqWxmZrMZbtaDZhk3+6llt3dN4lK2udHb7nCx
	9vsE6SGOtUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECE5058BA;
	Tue, 15 Nov 2011 11:27:06 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8110558B9; Tue, 15 Nov 2011
 11:27:06 -0500 (EST)
In-Reply-To: <20111115095225.GB23139@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Tue, 15 Nov 2011 03:52:25 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8989DB0-0FA6-11E1-8BA4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185466>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>> Yeah, git_path() writes to one of the four static buffers in
>> path.c:get_pathname().  Which brings me to: what should (can) we do
>> about it?
>
> Just use a sane idiom.  Which means: as few git_path() values in
> flight at a time as possible.
>
> In other words, do not save the git_path() result in a variable, but
> pass it directly to whatever computation needs to use it.

Or perhaps http://thread.gmane.org/gmane.comp.version-control.git/184963/focus=185436
