From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-filter-branch: document --original option
Date: Fri, 31 Aug 2007 08:13:36 +0200
Message-ID: <85642wcju7.fsf@lola.goethe.zz>
References: <11884893671845-git-send-email-giuseppe.bilotta@gmail.com>
	<1188493842963-git-send-email-giuseppe.bilotta@gmail.com>
	<11884938431525-git-send-email-giuseppe.bilotta@gmail.com>
	<7vy7fs7kmc.fsf@gitster.siamese.dyndns.org>
	<85d4x4d6oi.fsf@lola.goethe.zz>
	<7vodgo7jbn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 08:13:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQzlL-0006xO-PO
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 08:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598AbXHaGNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 02:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753572AbXHaGNo
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 02:13:44 -0400
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:53456 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754205AbXHaGNn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 02:13:43 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 468164C78C;
	Fri, 31 Aug 2007 08:13:42 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 3364F21300A;
	Fri, 31 Aug 2007 08:13:42 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-055-068.pools.arcor-ip.net [84.61.55.68])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 19CFD36E86A;
	Fri, 31 Aug 2007 08:13:37 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3D5181D3DB8A; Fri, 31 Aug 2007 08:13:36 +0200 (CEST)
In-Reply-To: <7vodgo7jbn.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 30 Aug 2007 15\:23\:40 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57120>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> ...
>>>  	--original)
>>> +		case "$OPTARG" in */) ;; *) OPTARG="$OPTARG/" ;; esac
>>>  		orig_namespace="$OPTARG"
>>>  		;;
>>>  	*)
>>
>> orig_namespace="${OPTARG%/}/"
>>
>> Sure, it does not win the "portable to Version 7" price, but our
>> scripts don't do that, anyway.
>
> I agree we do not give the "portable to version 7" prize
> anymore.  But you made me realize another thing.
>
> I think it should make sure orig_namespace has one and only one
> trailing slash, because otherwise "--original refs/heads//"
> would lead you to the same disaster.

I am not sure we should bend over backwards to people courting
disaster.  Completion does not add double slashes, and that's the most
common cause for spurious slashes.  And I don't know an equally
straightforward way to remove multiple slashes at the end.

do orig_namespace="$OPTARG";OPTARG="${OPTARG%/}/"
while test "X${orig_namespace}" != "X${OPTARG}"

is not really all too pretty.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
