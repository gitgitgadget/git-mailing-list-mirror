From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] receive-pack: optionally deny case clone refs
Date: Fri, 6 Jun 2014 08:37:55 +0700
Message-ID: <CACsJy8ALeYR1+5ox2GE2Rz3TRM5wqd9fxSCAnHoabo9fmuSdXQ@mail.gmail.com>
References: <1402015954-5320-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 03:38:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wsj70-0007eM-Qy
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 03:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbaFFBi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 21:38:27 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:62799 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbaFFBi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 21:38:26 -0400
Received: by mail-qg0-f50.google.com with SMTP id z60so3112175qgd.9
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 18:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WU5jW9TZ+WQEEILoRD7/xhGPZjPnZosg+7qdKwWfH7g=;
        b=A2kmqtgXLGRX0lixc77CXLmyao0iShNxnEtBEaO0+/0AM9YfkTRAaPW/c6kfA1LIaQ
         cBXUZNhj0UVLXWGBtuh1PcEYta8tIQ/G95MYUb0AK1mcXA2E4aDZTirGPccmMy8hruKW
         ICUk2icqOsnJYaSWUQ4Bh0uLi51RzdCES+IkoLFOVbyjQaVR3jU5Ielw3w1PFNKrJ118
         Y6nZqhB7Mx47uqWONgqi2Zkln96Gv3vOHrz+EIb62ZT4miVFpevtcpU/JWH2+PlALgVk
         9PAyJxd4FUWo235V5qVruSl6IwO08qJYIookgwhJMEtcdJArcDCwXvBANyHT57CF0y7T
         BpUA==
X-Received: by 10.140.91.161 with SMTP id z30mr2271572qgd.65.1402018705782;
 Thu, 05 Jun 2014 18:38:25 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Thu, 5 Jun 2014 18:37:55 -0700 (PDT)
In-Reply-To: <1402015954-5320-1-git-send-email-dturner@twitter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250886>

On Fri, Jun 6, 2014 at 7:52 AM, David Turner <dturner@twopensource.com> wrote:
> Create the option receive.denycaseclonerefs, which checks pushed
> refs to ensure that they are not case clones of an existing
> ref.  This setting is turned on by default if core.ignorecase is
> set, but not otherwise.

Just thinking out loud as I haven't had time to read this patch
carefully, but I wonder if there's a potential performance problem
with ref_is_denied_case_clone(). What if the receiver repo has 60k
refs? Should we use name-hash (or a variant of it)? What if the sender
pushes 60k refs in one go, will ref_is_denied_case_clone check against
existing refs only, or it will cover more and more refs from the 60k
input?
-- 
Duy
