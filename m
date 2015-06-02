From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv2 1/2] git-rebase -i: add command "drop" to remove a commit
Date: Tue, 02 Jun 2015 10:14:17 -0700
Message-ID: <xmqqk2vm3udy.fsf@gitster.dls.corp.google.com>
References: <1433152643-4292-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<1433152643-4292-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<xmqqvbf7757q.fsf@gitster.dls.corp.google.com>
	<563732680.250935.1433180720935.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqoakz1dke.fsf@anie.imag.fr>
	<150689518.4344.1433229813195.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqa8wiwo33.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Philip Oakley <philipoakley@iee.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 19:14:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzplm-0000Tk-IM
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 19:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759706AbbFBROX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 13:14:23 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36328 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759696AbbFBROU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 13:14:20 -0400
Received: by ieclw1 with SMTP id lw1so42919375iec.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2YC0lqgVO6RHYtGjnAq+saDJuTvhXSx4Soerm362/IM=;
        b=QSmp6Al5MaG0Oc35avMj6bPMdvYPhoIKYUUzq26NKbjJ98PaYooiFnKq3mtsJ3+D3l
         DZoKVfbKAR9wBgdDkrOGaThSZzU/vuP8MSw2eLWY9L2oNCNvuDX9mqbp9NJw6YQpwrmu
         YcRAL2OxBamuoOdapjVNOLuB3KTtZw70UAq+AWBjEV60/x5yLGaqacI1seltVxXAESp+
         ieT3kLnPg/TOl0kEmdUtPC4/WA48adhtfJ4756b+CcLsVzE2NzSx9Uom1OZ37OYpiLgs
         BqiGa2LW4n9dzdLwXaQ33js9eESPhn1wpGyEays67pz75XMXcW2+uz7lcLphuKgSFD+0
         OZFw==
X-Received: by 10.43.173.70 with SMTP id ob6mr940129icc.45.1433265259622;
        Tue, 02 Jun 2015 10:14:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id z195sm12885408iod.33.2015.06.02.10.14.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 10:14:18 -0700 (PDT)
In-Reply-To: <vpqa8wiwo33.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	02 Jun 2015 09:45:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270564>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Discussions on this list often lead to "Oh, BTW, shall we do XYZ also?",
> but you shouldn't take this kind of remark as blocking (as long as XYZ
> is not incompatible with your patch, which is the case here).

Yeah, thanks for clarification.  As long as what is given to 'drop'
is checked when it matters (e.g. when the code in patch 2/2 tries
see if some commits in the original list are no longer there in
order to warn sees "drop foo bar" where "foo" is obviously not an
object name in the original list, that should be checked), it is
fine.  And I agree 1/2 is not the place to do so, even though it may
be easier from the implementation point of view (which is why I
mentioned the possibility in the review of that patch).
