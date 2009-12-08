From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH/RFC 09/11] daemon: use run-command api for async 
	serving
Date: Tue, 8 Dec 2009 14:36:49 +0100
Message-ID: <40aa078e0912080536o21101f18p15c6c708b1cb6c14@mail.gmail.com>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
	 <200911272159.38757.j6t@kdbg.org>
	 <40aa078e0912020745o4b72342fm722a944621cfda5@mail.gmail.com>
	 <200912022012.08905.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: 3dFYeSwkOBzQakicQRYjUWeeWbUcQYb.SeccioiWYjWeeWbUWhekfi.Sec@listserv.bounces.google.com Tue Dec 08 14:37:12 2009
Return-path: <3dFYeSwkOBzQakicQRYjUWeeWbUcQYb.SeccioiWYjWeeWbUWhekfi.Sec@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-gx0-f190.google.com ([209.85.217.190])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI0Fb-00065f-LY
	for gcvm-msysgit@m.gmane.org; Tue, 08 Dec 2009 14:37:11 +0100
Received: by gxk6 with SMTP id 6sf8632931gxk.13
        for <gcvm-msysgit@m.gmane.org>; Tue, 08 Dec 2009 05:37:10 -0800 (PST)
Received: by 10.91.95.6 with SMTP id x6mr817932agl.18.1260279412917;
        Tue, 08 Dec 2009 05:36:52 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.77.68 with SMTP id f4ls208351ebk.2.p; Tue, 08 Dec 2009 
	05:36:51 -0800 (PST)
Received: by 10.213.61.142 with SMTP id t14mr1052035ebh.14.1260279411090;
        Tue, 08 Dec 2009 05:36:51 -0800 (PST)
Received: by 10.213.61.142 with SMTP id t14mr1052034ebh.14.1260279411069;
        Tue, 08 Dec 2009 05:36:51 -0800 (PST)
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.25])
        by gmr-mx.google.com with ESMTP id 12si666037ewy.14.2009.12.08.05.36.49;
        Tue, 08 Dec 2009 05:36:50 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 74.125.78.25 as permitted sender) client-ip=74.125.78.25;
Received: by ey-out-2122.google.com with SMTP id 22so1237083eye.7
        for <msysgit@googlegroups.com>; Tue, 08 Dec 2009 05:36:49 -0800 (PST)
Received: by 10.216.90.208 with SMTP id e58mr2786724wef.57.1260279409740; Tue, 
	08 Dec 2009 05:36:49 -0800 (PST)
In-Reply-To: <200912022012.08905.j6t@kdbg.org>
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of kusmabite@googlemail.com designates 74.125.78.25 as permitted 
	sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) 
	header.i=@googlemail.com
X-Original-Sender: <kusmabite@googlemail.com>
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/15f3dd983aa85143
X-Message-Url: http://groups.google.com/group/msysgit/msg/46a1f544979dc75d
Sender: msysgit+owner@googlegroups.com
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134868>

On Wed, Dec 2, 2009 at 8:12 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Mittwoch, 2. Dezember 2009, Erik Faye-Lund wrote:
>> I'm not entirely sure how to make the interface, though. Any good
>> suggestions?
>
> I suggest to model finish_async_nowait() after waitpid() so that
>
> =A0 =A0 =A0 =A0while ((pid =3D waitpid(-1, &status, WNOHANG)) > 0) ...
> becomes
> =A0 =A0 =A0 =A0while ((pid =3D finish_async_nowait(&some_async, &status))=
 > 0) ...
>
> but where the resulting status is already "decoded", i.e. zero is success=
 and
> non-zero is failure (including death through signal); WIFEXITED and
> WEXITSTATUS should not be applicable to status anymore.
>
> -- Hannes
>

Thanks. Implemented as suggested for the next round.

--=20
Erik "kusma" Faye-Lund
