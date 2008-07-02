From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 11/12] verify_path(): do not allow absolute
 paths
Date: Wed, 02 Jul 2008 02:21:15 -0700
Message-ID: <7vvdzobq0k.fsf@gitster.siamese.dyndns.org>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de> <1214987532-23640-4-git-send-email-prohaska@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de> <1214987532-23640-7-git-send-email-prohaska@zib.de> <1214987532-23640-8-git-send-email-prohaska@zib.de> <1214987532-23640-9-git-send-email-prohaska@zib.de> <1214987532-23640-10-git-send-email-prohaska@zib.de> <1214987532-23640-11-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>,  git@vger.kernel.org,  msysgit@googlegroups.com,  Johannes Schindelin <johannes.schindelin@gmx.de>
To: prohaska@zib.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 11:22:40 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.250])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDyXp-0001Ue-FQ
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 11:22:33 +0200
Received: by wa-out-0708.google.com with SMTP id n36so7019955wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-pobox-relay-id:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=jWo3xO5CnO5Yffy0Ok7d7In/Qlz1VvFD1hcqpyGeuUE=;
        b=h6lgsPQJdkhz6nmSdX2NAy6pnQYUCSNzxLr0DztAhcZy8aITdGU8GsIvEdD0n9Yypf
         rZTA+IB35TYYKHpx5X+DVu7yGTCKx/si79oUVv1Kwlepag+lEaUSdmJRBOeA7FO9m4WL
         Ey7mCGcix9LNz1ZhqMC7neHm/eGLd/WHGnhn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:cc:subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type:x-pobox-relay-id:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=MOU+jqgcySzI2EwbWk9gmmKmTDJhV1QwhUTrgve860kR1Egpy/QB/qUYGnRjtBu/13
         iTv3U/IP6blexqFlbjrdTrXeII16OdhbjqGrW8GKp6mG1ErXQrKfEI4pAMlmApxDlHdF
         t9saL/gd1pUwB2JL2Dp77aL/GRV6dPHlaMDLM=
Received: by 10.115.109.18 with SMTP id l18mr140204wam.29.1214990489719;
        Wed, 02 Jul 2008 02:21:29 -0700 (PDT)
Received: by 10.106.79.1 with SMTP id c1gr2560prb.0;
	Wed, 02 Jul 2008 02:21:29 -0700 (PDT)
X-Sender: junio@pobox.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.100.47.13 with SMTP id u13mr4756524anu.9.1214990489148; Wed, 02 Jul 2008 02:21:29 -0700 (PDT)
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com [207.106.133.19]) by mx.google.com with ESMTP id 39si7897937yxd.0.2008.07.02.02.21.29; Wed, 02 Jul 2008 02:21:29 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 207.106.133.19 as permitted sender) client-ip=207.106.133.19;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of junio@pobox.com designates 207.106.133.19 as permitted sender) smtp.mail=junio@pobox.com
Received: from localhost.localdomain (localhost [127.0.0.1]) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D17A28A1D; Wed,  2 Jul 2008 05:21:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77]) (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B3A3828A1A; Wed,  2 Jul 2008 05:21:22 -0400 (EDT)
In-Reply-To: <1214987532-23640-11-git-send-email-prohaska@zib.de> (Steffen Prohaska's message of "Wed, 2 Jul 2008 10:32:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4041CF88-4818-11DD-875E-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87124>


Steffen Prohaska <prohaska@zib.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>

No commit log message?  Justification?
