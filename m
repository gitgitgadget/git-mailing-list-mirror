From: Michael Spang <spang@google.com>
Subject: Re: [PATCH] Fix git rev-list --reverse --max-count=N
Date: Wed, 27 Jan 2010 17:21:47 -0500
Message-ID: <abef960f1001271421s6c0f72f7xd2697ab34b53d1ea@mail.gmail.com>
References: <1264622600-20981-1-git-send-email-spang@google.com>
	 <201001272309.26054.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 23:22:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaGGs-0005MT-Q0
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 23:21:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204Ab0A0WVx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2010 17:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756201Ab0A0WVx
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 17:21:53 -0500
Received: from smtp-out.google.com ([216.239.33.17]:59763 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756200Ab0A0WVw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 17:21:52 -0500
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id o0RMLnOo002614
	for <git@vger.kernel.org>; Wed, 27 Jan 2010 22:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1264630910; bh=kGrV/POrgWXKm6ad+zQqcep+yyE=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=TNywg4qblUMSG6pg2cUQmIxEM8ykzlAYKdCa4fDlIv6fJSBYIox/E2QfNelw+0RN9
	 dsWclteJe02/Qh5X4trKA==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to:
	cc:content-type:content-transfer-encoding:x-system-of-record;
	b=N8DuyDj+xJwAzV6GW3frPvCVWVhv6qhKrbhZ6QbpmBoXVs5HHNhkLlGbz94ukcEHO
	HVmOIieYueNNBMT1mZqNg==
Received: from fg-out-1718.google.com (fgbl26.prod.google.com [10.86.88.26])
	by wpaz29.hot.corp.google.com with ESMTP id o0RMLmg3006344
	for <git@vger.kernel.org>; Wed, 27 Jan 2010 14:21:48 -0800
Received: by fg-out-1718.google.com with SMTP id l26so758508fgb.7
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 14:21:48 -0800 (PST)
Received: by 10.103.81.5 with SMTP id i5mr5017180mul.29.1264630907843; Wed, 27 
	Jan 2010 14:21:47 -0800 (PST)
In-Reply-To: <201001272309.26054.j6t@kdbg.org>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138202>

On Wed, Jan 27, 2010 at 5:09 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Mittwoch, 27. Januar 2010, Michael Spang wrote:
>
> So when you have this history (A is oldest, D is newest):
>
> =A0 A--B--C--D
>
> and you say
>
> =A0 git log --max-count=3D2 --reverse D
>
> then you want
>
> =A0 A
> =A0 B
>
> but I want
>
> =A0 C
> =A0 D
>
> Why is your interpretation correct, an mine wrong?

Perhaps not wrong, but for me it was unexpected. For whatever reason,
I expected "--reverse" to give you the illusion that you are iterating
from the beginning of the history, even if it's not actually possible
to iterate that way directly. In line with that, limiting the output
to N commits would give you the earliest N commits. If you instead
think "stop descending through the history once we have N commits" the
current behavior makes sense.

I talked to Junio and he says the current behavior is here to stay.

Michael
