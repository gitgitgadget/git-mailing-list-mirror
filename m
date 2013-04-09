From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository boundaries
Date: Tue, 09 Apr 2013 20:32:38 +0200
Message-ID: <51645EC6.407@gmail.com>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com> <1365499297-8667-1-git-send-email-artagnon@gmail.com> <1365499297-8667-3-git-send-email-artagnon@gmail.com> <7v4nfftyu3.fsf@alter.siamese.dyndns.org> <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 20:32:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPdLa-0002Ij-RX
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 20:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935019Ab3DIScm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 14:32:42 -0400
Received: from mail-ea0-f176.google.com ([209.85.215.176]:43064 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934538Ab3DIScm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 14:32:42 -0400
Received: by mail-ea0-f176.google.com with SMTP id h10so3073782eaj.21
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 11:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=soVADUAFgVTfuStdiFfO+6zspGrUU03RG8Y+Up2hb88=;
        b=LvPPHvjGcmnwskHUKwL0Fg4yEa+jITDFp1xeriXZik1rnWlEADeTqohLHWOKEZ7uk/
         jJT197asUzJ/Ih1MEvnfK0yFcSN9Jr4nCrnze9NcGzqlykf/ZUhurylgoBGdAUlRuZ3T
         m1twGMJjB882F41+pCp+tbAL/kavx0oifnfIsCycmQSZSxxURBpeT+8rwP3LFU3v/Est
         1mcnOxCyFn7kStddRFOKYokvfxFJgfg9d7nts08EIEvhXoE5zqCZhrADJa7qHfO/XQHk
         VA6eA5DTaRkF9q/IQbBApNAQYiUNJOcB6t+tAlQ2nHQQ10w2OOqYlq/sJIUfDmLuiE2c
         iSTg==
X-Received: by 10.14.107.69 with SMTP id n45mr40736227eeg.23.1365532360791;
        Tue, 09 Apr 2013 11:32:40 -0700 (PDT)
Received: from [192.168.1.14] (dce9.neoplus.adsl.tpnet.pl. [83.23.56.9])
        by mx.google.com with ESMTPS id i53sm10225489eeu.5.2013.04.09.11.32.39
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 11:32:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <7vvc7vsj4p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220610>

W dniu 09.04.2013 19:34, Junio C Hamano pisze:

> -	if (has_symlink_leading_path(path, len))
> -		return error("'%s' is beyond a symbolic link", path);
> +	if (path_outside_our_project(path, len))
> +		return error("'%s' is outside our working tree", path);
> =20

Don't we lose important information here?  Or we shouldn't care?

--=20
Jakub Nar=C4=99bski
