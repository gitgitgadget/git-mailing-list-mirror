From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 08/11] Place __stdcall to correct position.
Date: Tue, 18 Aug 2009 09:51:34 +0800
Message-ID: <1976ea660908171851n16b8b56j378ace9ecf0ce272@mail.gmail.com>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-2-git-send-email-lznuaa@gmail.com>
	 <1250525103-5184-3-git-send-email-lznuaa@gmail.com>
	 <alpine.DEB.1.00.0908171859060.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 03:51:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdDrS-0006mV-AL
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 03:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758584AbZHRBvd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 21:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758582AbZHRBvd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 21:51:33 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:47539 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758531AbZHRBvd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 21:51:33 -0400
Received: by qyk34 with SMTP id 34so2497880qyk.33
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 18:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YuDVrm6EoeZKLUddqmJYE/p1w+R3cYZ72cSZvtToFZc=;
        b=s+K93g3HeJpKbRpoae3Wd+succoPySOsML8br023moQ/Tk1Jku/x26iEQ9hsnFlQJU
         OJ2lksMYHViHvwWX3lg2JSP2pNxP7fenaGiYcXFusXwIKdQ/H58YCxuTaNdPwkOIZ7bD
         kuBSWAx3Iemu2jNkqf9TYidztwURzR0s+kvew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hpZBKSEvLql3hmDmddTqpuB3tcjhfu84sLJmBRnaoBYmx4km46mEk1ssM6CHuqIVsj
         OIRUbTgTqUqe80BpPda4iTpMIivxr7HlPQ2LiQUhrI76RVKeoAY1AV155han3JQdb2kf
         0qUe6kV0Lkkm95TcPSGSmduHXJDVT5gCKRvRM=
Received: by 10.224.108.138 with SMTP id f10mr4903944qap.20.1250560294042; 
	Mon, 17 Aug 2009 18:51:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171859060.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126338>

> How about "... to the correct ..." and "MSVC requires _stdcall to be
> between return value..." and "All Win32 API functions are declared wi=
th
> the WINAPI attribute."?

WINAPI always like

BOOL WINAPI function_name(xxx);
It compile fail if WINAPI BOOL function_name(xxx);

>> =A0#if defined(__MINGW32__) || defined(_MSC_VER)
>> -static __stdcall unsigned run_thread(void *data)
>> +static unsigned __stdcall run_thread(void *data)
>> =A0{
>> =A0 =A0 =A0 struct async *async =3D data;
>> =A0 =A0 =A0 return async->proc(async->fd_for_proc, async->data);
>> =A0}
>> -#endif
>> +#endif /* __MINGW32__ || _MSC_VER */
>
> I do not think this is necessary. =A0There are only 5 lines wrapped i=
nto
> those #ifdef guards, the developer should be able to see that far.
>
Do you means remove /* __MINGW32__ || _MSC_VER */?
