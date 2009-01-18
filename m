From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into 
	submodules
Date: Sun, 18 Jan 2009 20:50:06 +0100
Message-ID: <8c5c35580901181150t1827455elbe2be224a33f1b36@mail.gmail.com>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
	 <1232275999-14852-2-git-send-email-hjemli@gmail.com>
	 <1232275999-14852-3-git-send-email-hjemli@gmail.com>
	 <49735530.4090901@lsrfire.ath.cx>
	 <8c5c35580901180837i6e835d98ob8875ce1b8ad3011@mail.gmail.com>
	 <7vfxjgxwv7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 20:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOdgD-00050D-CA
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 20:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754026AbZARTuK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 14:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbZARTuJ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 14:50:09 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:27979 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbZARTuH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jan 2009 14:50:07 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1319321wah.21
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 11:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=x2Zw45aXPS79teDEWFBKMv8n3f98KeCYXiX/mYW6PD0=;
        b=QNaadrxf1siocjg2nd/JERf4L79yOuyXEJ96I4L+9h3OoUVpDfLaYIK4fl+zD/IvEI
         OkBTKF+zcE6UbNtpqvn50Q6OQLzkKU4PwY4q/L5Vky6gXmJ4sLvowTdD49zG9vkEHVyG
         N59VZ9bRD+euaoL0IA5W3IX1dmmi8Lnv8M030=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LLFOvuTNeBTxG17QsGVLkWbYrTeeZQtGNaTogCJDPQIIw7OCs8Jy0dz06xDFF0K8Za
         Tmy+CHW50a6PJIW4r/VI+9U3wK06CFrE9G/bvUhNy1/PcKcv/oxnawcbQTH75phRGXax
         tD8b16Vw+5FuNoAe7uBY4aMAG15pL2j7cMAXY=
Received: by 10.114.26.18 with SMTP id 18mr3487135waz.159.1232308206206; Sun, 
	18 Jan 2009 11:50:06 -0800 (PST)
In-Reply-To: <7vfxjgxwv7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106271>

On Sun, Jan 18, 2009 at 20:00, Junio C Hamano <gitster@pobox.com> wrote=
:
> Lars Hjemli <hjemli@gmail.com> writes:
>
>> I like the idea, but it will require thorough review of all
>> read_tree_recursive() consumers. So now we've got three different
>> approaches:
>> * me: global setting
>> * dscho: parameter to read_tree_recursive()
>> * you: accept the return value from the callback function
>>
>> Junio, what would you prefer?
>
> As usual Ren=C3=A9 has the best taste in designing things ;-)

Agreed. I've pushed an updated series using his approach to the
lh/traverse-gitlinks branch in git://hjemli.net/pub/git/git
(http://hjemli.net/git/git/log/?h=3Dlh/traverse-gitlinks), but without =
a
fix for Dscho's concern about the behaviour in
tree.c::traverse_gitlink(). Hopefully I'll get to send a reworked
series later tonight.

--
larsh
