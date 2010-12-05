From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Intermittent failures in t9119
Date: Sat, 04 Dec 2010 20:50:33 -0800
Message-ID: <7vwrnox1pi.fsf@alter.siamese.dyndns.org>
References: <7vmxoml1p7.fsf@alter.siamese.dyndns.org>
 <97465.53475.qm@web30008.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Sun Dec 05 05:50:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PP6Yl-000858-03
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 05:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab0LEEuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 23:50:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab0LEEun (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 23:50:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 16F8435E2;
	Sat,  4 Dec 2010 23:51:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UmhaE7sNgpYIp8SFS0J89ccpMQU=; b=sd54iU
	af2mKB8DzwPgnPkIKKlUe2YAMAUKkRn0JzmMoMy9Zt1Exy8dpKNSDq2aMXx2+30f
	V8ohkgeYUi64igQi3GB9AqxkuOiqZUW/dnR2XoTGRB4qB2kQcwRcu/JJoMyTolXY
	hMlIp3ESEJisBL9aVncS1WiLl5g1EA9ir1WQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JsX6/OTKbKPlf/hf33PNN8HTxCuN/hXk
	uIez6mfKU1hzvyaQv/YsNbNZ6lshHvBy5499P+6+hoo4wskRjxXA1pYxIy4d0pdk
	KyIKlU+21PBvHewGOqgbZRzomUNpcVNNxbitVYz8N1vLGG8WaRSXJ9stHI0wsrYv
	xqxJStgyogI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E993735E1;
	Sat,  4 Dec 2010 23:50:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0383135DF; Sat,  4 Dec 2010
 23:50:56 -0500 (EST)
In-Reply-To: <97465.53475.qm@web30008.mail.mud.yahoo.com> (David D. Kilzer's
 message of "Sat\, 4 Dec 2010 17\:21\:38 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 413BAA6C-002B-11E0-9D2B-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162927>

"David D. Kilzer" <ddkilzer@kilzer.net> writes:

> The modification timestamp (mtime) for the two files should be in sync due to 
> this line in t9119-git-svn-info.sh in 'setup repository and import':
>
>         ptouch gitwc/file svnwc/file &&

Hmph.  One explanation that may make sense is that something else is
touching the file in the working tree after you run your ptouch script,
but I don't know what it is.

>> I  _think_ "svn info file" actually gives the timestamp of the revision
>> that  touched the file the last (in their linear worldview of the history),
>> so  perhaps this is demonstrating the real bug, but only when the test runs
>> very  slowly?
>
> What platform/OS is the test failing on?

An FC13 machine at k.org; I see 16 "Xeon X5550 @ 2.67GHz" in /proc/cpuinfo
output.
