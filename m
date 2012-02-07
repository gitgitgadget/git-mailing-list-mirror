From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] commit: introduce a config key to allow as-is commit
 with i-t-a entries
Date: Mon, 06 Feb 2012 23:57:43 -0800
Message-ID: <7vwr7z2hzc.fsf@alter.siamese.dyndns.org>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-3-git-send-email-pclouds@gmail.com>
 <7vwr7z653f.fsf@alter.siamese.dyndns.org>
 <7v1uq741ip.fsf@alter.siamese.dyndns.org>
 <CACsJy8CaFhyzgh6N4ov49Tf0mA8qV5uQESFP2u8U7AduOd59PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 08:57:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rufw0-0003sY-Ab
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 08:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092Ab2BGH5r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 02:57:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349Ab2BGH5q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 02:57:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C46692641;
	Tue,  7 Feb 2012 02:57:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7XI06dbGbbV+
	6wfzTj80+O96M0g=; b=SSPJdLmQjXMZCAXawyS8YU6hCWWKBPjS3XOzjmFPWXLW
	CgHuZJBeI/ZeBzQ8eFp00SQQhBoSZkdERxjCMNDrOo5tJ0pX57ie7f+m+WdIYx8P
	KFYMlgna26YPsbkscxvzAeTFoDuPweoQFXHcCD8XS8LGU6vfzh0cN1uKuForFNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=R9vrmp
	Wz6pPV8t9sVmcPHw+lrhoje5w7SdxdxJlByPXnSLVf12czojAlmOQuPdPlVsvAm6
	uxP91D0ZHucKodqV6tU1Hb1QLXncAT58UkN/ZRVJIVpXNIpMFpGE2CDSpLGw+LmA
	qZfnLIoPGJVPVpsKVr+uadP5KifVJ7RVUv/v4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC8992640;
	Tue,  7 Feb 2012 02:57:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50020263E; Tue,  7 Feb 2012
 02:57:45 -0500 (EST)
In-Reply-To: <CACsJy8CaFhyzgh6N4ov49Tf0mA8qV5uQESFP2u8U7AduOd59PA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 7 Feb 2012 13:26:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6B669B84-5161-11E1-AF1A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190151>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2012/2/7 Junio C Hamano <gitster@pobox.com>:
>> Unless you are doing "commit -a" or "commit pathspec", you are respo=
nsible
>> for adding all contents you want to have in the commit before you ru=
n the
>> "git commit" command (and for the purpose of this statement, "add -N=
" to
>> tell Git to keey an eye on a path does _not_ add contents). A change=
 to
>> the file in the working tree that is left unadded is what you decide=
d to
>> deliberately leave out of the commit, be it a change to a path alrea=
dy in
>> HEAD, or a path marked with "add -N". =C2=A0Forgetting to add modifi=
ed file and
>> forgetting to add a file you earlier used "add -N" amount to the sam=
e kind
>> of risk, and "git status" is the way to make sure your partial commi=
t has
>> exactly what you want (if you are not worried about partial commit, =
you
>> would be doing "commit -a", so the "safety" is a moot point).
>
> We need something in the commit message so that 5 years from now, whe=
n
> someone raises the issue again, (s)he does not have to search the mai=
l
> archive. May I steal the above paragraph, maybe rephrase a little bit=
,
> for commit message?

Surely, and thanks.
