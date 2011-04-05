From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git exhausts memory.
Date: Tue, 05 Apr 2011 15:16:12 -0700
Message-ID: <7vmxk4l4yb.fsf@alter.siamese.dyndns.org>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
 <alpine.LFD.2.00.1104021103130.28032@xanadu.home>
 <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
 <alpine.LFD.2.00.1104031110150.28032@xanadu.home>
 <BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
 <BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com>
 <4D9B47D2.6050909@ira.uka.de>
 <BANLkTikanSa3D1Bd8kSySPWQhcj1y8N+qA@mail.gmail.com>
 <7vzko4mw44.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1104051655310.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Alif Wahid <alif.wahid@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Apr 06 00:16:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7EYA-0002fQ-1H
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 00:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab1DEWQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 18:16:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab1DEWQa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 18:16:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D83E9510F;
	Tue,  5 Apr 2011 18:18:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BcXd2zS9bU285qXvccLw02q0VsE=; b=kh3Ywi
	wwpbyelo84vSnzo3FlwvvOXaKR89MCWMlMAtWW7Jv6zso3MUC/TaTzM3aNnXOLjE
	FIu8EdaLYZuqae7KamgnFkDuZA6ocGA7wWL6Xbtya1qgo7vS1MenKdPIOQEZBLjP
	/aMYAh93HPGEVAR8XPLHmiMnRvAq7ocgH8pBI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lzB43caltqzH2b21l+Cw4GM6qhZ20Lde
	gCcz/cLxfdSPcFmD2dGdHc+34HU3Fr9ObpEIcfScDylHmQmGG8XLvdWTsdW4/BUc
	KQESpLiMt+vWOXU5GLmhVvAfWxZ0V1/op8Ft4yFj0/3BIh8J+VNE8X9C4oRrVc8Z
	E+Nx8/7NjGw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57652510E;
	Tue,  5 Apr 2011 18:18:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EC7475103; Tue,  5 Apr 2011
 18:18:06 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1104051655310.28032@xanadu.home> (Nicolas
 Pitre's message of "Tue, 05 Apr 2011 16:56:20 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A0157DA-5FD2-11E0-A726-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170926>

Nicolas Pitre <nico@fluxnic.net> writes:

>> > This is only implemented inside of fast-import. pack-objects does not
>> > honor this variable.
>> 
>> Do you mean perhaps we should?
>
> Yes.
>
> Acked-by: Nicolas Pitre <nico@fluxnic.net>

I actually was somewhat unhappy to use uintmax_t type in the public header
for some reason I cannot quite explain (perhaps religious), and was hoping
somebody with more sanity than myself would stop me or show me a better
way.

>> diff --git a/cache.h b/cache.h
>> index 2674f4c..316d85f 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -573,6 +573,7 @@ extern int core_compression_seen;
>>  extern size_t packed_git_window_size;
>>  extern size_t packed_git_limit;
>>  extern size_t delta_base_cache_limit;
>> +extern uintmax_t big_file_threshold;
>>  extern int read_replace_refs;
>>  extern int fsync_object_files;
>>  extern int core_preload_index;
