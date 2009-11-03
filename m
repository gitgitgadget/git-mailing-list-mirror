From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Re: Gitk --all error when there are more than 797 refs in 
	a repository
Date: Tue, 3 Nov 2009 11:04:44 +0100
Message-ID: <81b0412b0911030204v46adf54gb9ed65e78ce2b6df@mail.gmail.com>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
	 <878wgcbb52.fsf@users.sourceforge.net>
	 <19124.8378.975976.347711@cargo.ozlabs.ibm.com>
	 <6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com>
	 <4AB78910.7010402@viscovery.net>
	 <6F87406399731F489FBACE5C5FFA0458518E11@ex2k.bankofamerica.com>
	 <4AB7A2E7.5000601@viscovery.net>
	 <874oqvc0n3.fsf@users.sourceforge.net>
	 <7v1vlzvjtg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	"Murphy, John" <john.murphy@bankofamerica.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 11:04:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5GFy-0004y7-UH
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 11:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbZKCKEm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 05:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755468AbZKCKEm
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 05:04:42 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:44082 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbZKCKEl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2009 05:04:41 -0500
Received: by bwz27 with SMTP id 27so7368944bwz.21
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 02:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9deG3rC15IA1IV4oL0unFIs+zOlN/50UyLU7qTaWrbE=;
        b=TAORSEdXQR06yHT47IR+CL6kxS3h+5Dny9U6zE3eLLhwjq3eBF/IlRwkhmZR/EpLpg
         xpEH2i2ONU+SQ9x2VnvsEBSzhmf0sI8AMbtJVqbujOcB2S1N5ijINDvDZYSC2LemKNaZ
         ZjI+SU2IAPHBtIxc3M5qaShiIDU03fBy3O9ZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=L8yuSL9GG8+rh1Tft3YshvFopLLTFOyIckeeuRoO1R1Uzx919UTBNeaZDu6IABlPpi
         t4IJwcQ7cNLJr4peKTwFJB5Hx8oUUT05OxDNOiksu9FVkMQQwGbfziJqxjBLner/ppu7
         8hObhyWZQl7vabzsD+lQigTEg3E6jzh4ODvU0=
Received: by 10.204.153.22 with SMTP id i22mr50216bkw.123.1257242684919; Tue, 
	03 Nov 2009 02:04:44 -0800 (PST)
In-Reply-To: <7v1vlzvjtg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131959>

On Tue, Sep 22, 2009 at 02:39, Junio C Hamano <gitster@pobox.com> wrote=
:
> Pat Thoyts <patthoyts@users.sourceforge.net> writes:
>> =C2=A0 =C2=A0 =C2=A0if {$revs eq {}} {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 set revs HEAD
>> + =C2=A0 =C2=A0} elseif {$revs eq "--all"} {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return $revs
>> =C2=A0 =C2=A0 =C2=A0}
>
> That looks like an ugly hack (aka sweeping the issue under the rug).
>

And it is a race condition. By the time git log has got --all list of r=
eferences
it may look completely different to what gitk has.
