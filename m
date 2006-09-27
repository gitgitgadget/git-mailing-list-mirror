From: Len Brown <len.brown@intel.com>
Subject: Re: apply-mbox claiming corrupt patch.
Date: Tue, 26 Sep 2006 23:01:12 -0400
Organization: Intel Open Source Technology Center
Message-ID: <200609262301.12235.len.brown@intel.com>
References: <20060927024628.GA29182@redhat.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 04:59:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSPdh-0006Ls-R5
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 04:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWI0C7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 26 Sep 2006 22:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWI0C7K
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 22:59:10 -0400
Received: from hera.kernel.org ([140.211.167.34]:57014 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932192AbWI0C7J convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 22:59:09 -0400
Received: from lenb-laptop (c-24-63-232-79.hsd1.ma.comcast.net [24.63.232.79])
	(authenticated bits=0)
	by hera.kernel.org (8.13.7/8.13.7) with ESMTP id k8R2weIs026642
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Wed, 27 Sep 2006 02:59:05 GMT
To: Dave Jones <davej@redhat.com>
User-Agent: KMail/1.8.2
In-Reply-To: <20060927024628.GA29182@redhat.com>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.4/1947/Wed Sep 27 00:46:56 2006 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.1.3
X-Spam-Checker-Version: SpamAssassin 3.1.3 (2006-06-01) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27859>

I ran into a similar problem recently -- though looking
at the patch below I can't prove it is the exact same problem.

Patch appears to put a space, + or - on each line.
Somebody edited their patch with kate, and that automatically
"cleaned up" the lines with just a space on them -- leaving
them completely blank.

patch ate the result, but git-am (and git-apply) did not.
fixed it by refreshing with quilt.

-Len

On Tuesday 26 September 2006 22:46, Dave Jones wrote:
> I tried to apply the mail below to my cpufreq.git tree on master.kern=
el.org,
> and got ..
>=20
> $ git-applymbox -k mbox
> 1 patch(es) to process.
>=20
> Applying '[CPUFREQ] Longhaul - Disable arbiter CLE266'
>=20
> fatal: corrupt patch at line 99
>=20
> I don't see what the problem is.  It applies fine with patch...
>=20
> (22:44:48:davej@hera:cpufreq)$ cat 1 | patch -p1 --dry-run
> patching file arch/i386/kernel/cpu/cpufreq/longhaul.c
> (22:44:53:davej@hera:cpufreq)$=20
>=20
> I'm guessing it didn't like one of the headers, but chopping
> some of them out hasn't seemed to improve things.
>=20
> 	Dave
>=20
>=20
> >From davej@redhat.com  Sun Sep 24 18:31:11 2006
> Return-Path: <davej@redhat.com>
> Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
> 	by hera.kernel.org (8.13.7/8.13.7) with ESMTP id k8OIUhQv017025
> 	for <davej@kernel.org>; Sun, 24 Sep 2006 18:31:08 GMT
> Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.=
16.52.254])
> 	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k8OIUh5D0=
22511
> 	for <davej@kernel.org>; Sun, 24 Sep 2006 14:30:43 -0400
> Received: from pressure.kernelslacker.org (vpn-248-6.boston.redhat.co=
m [10.13.248.6])
> 	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id =
k8OIUgGp026807
> 	for <davej@kernel.org>; Sun, 24 Sep 2006 14:30:42 -0400
> Received: from pressure.kernelslacker.org (localhost.localdomain [127=
=2E0.0.1])
> 	by pressure.kernelslacker.org (8.13.8/8.13.8) with ESMTP id k8OIUfs6=
013171
> 	for <davej@kernel.org>; Sun, 24 Sep 2006 14:30:41 -0400
> Received: (from davej@localhost)
> 	by pressure.kernelslacker.org (8.13.8/8.13.8/Submit) id k8OIUfjO0131=
70
> 	for davej@kernel.org; Sun, 24 Sep 2006 14:30:41 -0400
> Resent-Message-Id: <200609241830.k8OIUfjO013170@pressure.kernelslacke=
r.org>
> X-Authentication-Warning: pressure.kernelslacker.org: davej set sende=
r to davej@redhat.com using -f
> X-Spam-Checker-Version: SpamAssassin 3.1.3 (2006-06-01) on hera.kerne=
l.org
> X-Spam-Level:=20
> X-Spam-Status: No, score=3D-2.5 required=3D5.0 tests=3DAWL,BAYES_00,
> 	FORGED_RCVD_HELO,UNPARSEABLE_RELAY autolearn=3Dham version=3D3.1.3
> Received: from pobox.devel.redhat.com [10.11.255.8]
> 	by pressure.kernelslacker.org with IMAP (fetchmail-6.3.4)
> 	for <davej@localhost> (single-drop); Sun, 24 Sep 2006 14:19:33 -0400=
 (EDT)
> Received: from pobox.devel.redhat.com ([unix socket])
> 	 by pobox.devel.redhat.com (Cyrus v2.2.12-Invoca-RPM-2.2.12-3.RHEL4.=
1) with LMTPA;
> 	 Sun, 24 Sep 2006 14:19:00 -0400
> X-Sieve: CMU Sieve 2.2
> Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.=
16.52.254])
> 	by pobox.devel.redhat.com (8.13.1/8.13.1) with ESMTP id k8OIIxSA0322=
50
> 	for <davej@pobox.devel.redhat.com>; Sun, 24 Sep 2006 14:19:00 -0400
> Received: from mx3.redhat.com (mx3.redhat.com [172.16.48.32])
> 	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id =
k8OIIxG3022438
> 	for <davej@redhat.com>; Sun, 24 Sep 2006 14:18:59 -0400
> Received: from smtp4.poczta.interia.pl (smtp11.poczta.interia.pl [80.=
48.65.11])
> 	by mx3.redhat.com (8.13.1/8.13.1) with ESMTP id k8OIIpQq020496
> 	for <davej@redhat.com>; Sun, 24 Sep 2006 14:18:51 -0400
> Received: by smtp4.poczta.interia.pl (INTERIA.PL, from userid 502)
> 	id 85328D228F; Sun, 24 Sep 2006 20:18:50 +0200 (CEST)
> Received: from poczta.interia.pl (mi02.poczta.interia.pl [10.217.12.2=
])
> 	by smtp4.poczta.interia.pl (INTERIA.PL) with ESMTP id DFEF4D2265;
> 	Sun, 24 Sep 2006 20:18:49 +0200 (CEST)
> Received: by poczta.interia.pl (INTERIA.PL, from userid 502)
> 	id D1C072BD043; Sun, 24 Sep 2006 20:18:49 +0200 (CEST)
> Received: from [172.16.5.114] (unknown [81.15.157.150])
> 	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
> 	(No client certificate requested)
> 	by poczta.interia.pl (INTERIA.PL) with ESMTP id ECF6C2BD0BC;
> 	Sun, 24 Sep 2006 20:18:45 +0200 (CEST)
> Message-ID: <4516CE3D.5050101@interia.pl>
> Date: Sun, 24 Sep 2006 20:28:13 +0200
> From: =3D?ISO-8859-2?Q?Rafa=3DB3_Bilski?=3D <rafalbilski@interia.pl>
> User-Agent: Thunderbird 1.5.0.5 (X11/20060805)
> MIME-Version: 1.0
> To: Dave Jones <davej@redhat.com>
> Cc: cpufreq@lists.linux.org.uk
> Subject: [CPUFREQ] Longhaul - Disable arbiter CLE266
> X-Enigmail-Version: 0.94.0.0
> Content-Type: text/plain; charset=3DISO-8859-2
> Content-Transfer-Encoding: 8bit
> X-EMID: d25b6acc
> X-RedHat-Spam-Score: 0=20
> Resent-From: davej@redhat.com
> Resent-Date: Sun, 24 Sep 2006 14:30:41 -0400
> Resent-To: davej@kernel.org
> X-Virus-Scanned: ClamAV 0.88.4/1931/Sun Sep 24 07:51:08 2006 on hera.=
kernel.org
> X-Virus-Status: Clean
> Status: RO
> Content-Length: 3399
> Lines: 114
>=20
> Please ignore previous message.
>=20
> This patch is adding support for CPU connected to CLE266=20
> chipset. For older CPU this is only way. For "Powersaver"=20
> processor this way will be used if ACPI C3 isn't supported.
>=20
> I have tested it. It seems to work exacly like ACPI.=20
> But it is less safe. On CLE266 chipset port 0x22 is=20
> blocking processor access to PCI bus too.
>=20
> Signed-off-by: Rafa=B3 Bilski <rafalbilski@interia.pl>
> Signed-off-by: Dave Jones <davej@redhat.com>
>=20
> ---
>=20
> diff --git a/arch/i386/kernel/cpu/cpufreq/longhaul.c b/arch/i386/kern=
el/cpu/cpufreq/longhaul.c
> --- a/arch/i386/kernel/cpu/cpufreq/longhaul.c
> +++ b/arch/i386/kernel/cpu/cpufreq/longhaul.c
> @@ -178,11 +178,17 @@ static void do_powersaver(int cx_address
>  	safe_halt();
>  	/* Change frequency on next halt or sleep */
>  	wrmsrl(MSR_VIA_LONGHAUL, longhaul.val);
> -	ACPI_FLUSH_CPU_CACHE();
> -	/* Invoke C3 */
> -	inb(cx_address);
> -	/* Dummy op - must do something useless after P_LVL3 read */
> -	t =3D inl(acpi_fadt.xpm_tmr_blk.address);
> +	if (port22_en) {
> +		ACPI_FLUSH_CPU_CACHE();
> +		/* Invoke C1 */
> +		halt();
> +	} else {
> +		ACPI_FLUSH_CPU_CACHE();
> +		/* Invoke C3 */
> +		inb(cx_address);
> +		/* Dummy op - must do something useless after P_LVL3 read */
> +		t =3D inl(acpi_fadt.xpm_tmr_blk.address);
> +	}
> =20
>  	/* Disable bus ratio bit */
>  	local_irq_disable();
> @@ -567,16 +573,23 @@ static acpi_status longhaul_walk_callbac
>  static int enable_arbiter_disable(void)
>  {
>  	struct pci_dev *dev;
> +	int reg;
>  	u8 pci_cmd;
> =20
>  	/* Find PLE133 host bridge */
> +	reg =3D 0x78;
>  	dev =3D pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8601_0=
, NULL);
> +	/* Find CLE266 host bridge */
> +	if (dev =3D=3D NULL) {
> +		dev =3D pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_862X_=
0, NULL);
> +		reg =3D 0x76;
> +	}
>  	if (dev !=3D NULL) {
>  		/* Enable access to port 0x22 */
> -		pci_read_config_byte(dev, 0x78, &pci_cmd);
> +		pci_read_config_byte(dev, reg, &pci_cmd);
>  		if ( !(pci_cmd & 1<<7) ) {
>  			pci_cmd |=3D 1<<7;
> -			pci_write_config_byte(dev, 0x78, pci_cmd);
> +			pci_write_config_byte(dev, reg, pci_cmd);
>  		}
>  		return 1;
>  	}
> @@ -681,19 +694,29 @@ static int __init longhaul_cpu_init(stru
>  		/* Check ACPI support for C3 state */
>  		cx =3D &pr->power.states[ACPI_STATE_C3];
>  		if (cx->address =3D=3D 0 ||
> -		   (cx->latency > 1000 && ignore_latency =3D=3D 0) )
> -			goto err_acpi;
> +		   (cx->latency > 1000 && ignore_latency =3D=3D 0) ) {
> +			if (enable_arbiter_disable()) {
> +				port22_en =3D 1;
> +			} else {
> +				goto err_acpi;
> +			}
> +		}
> =20
>  	} else {
>  		/* Check ACPI support for bus master arbiter disable */
>  		if (!pr->flags.bm_control) {
> -			if (!enable_arbiter_disable()) {
> -				printk(KERN_ERR PFX "No ACPI support. No VT8601 host bridge. Abo=
rting.\n");
> -				return -ENODEV;
> -			} else
> +			if (enable_arbiter_disable()) {
>  				port22_en =3D 1;
> +			} else {
> +				goto err_acpi;
> +			}
>  		}
>  	}
> +	if (!port22_en) {
> +		printk (KERN_INFO PFX "Using ACPI support.\n");
> +	} else {
> +		printk (KERN_INFO PFX "Using northbridge support.\n");
> +	}
> =20
>  	ret =3D longhaul_get_ranges();
>  	if (ret !=3D 0)
> @@ -716,7 +739,7 @@ static int __init longhaul_cpu_init(stru
>  	return 0;
> =20
>  err_acpi:
> -	printk(KERN_ERR PFX "No ACPI support for CPU frequency changes.\n")=
;
> +	printk(KERN_ERR PFX "No ACPI support. No VT8601 or VT8623 northbrid=
ge. Aborting.\n");
>  	return -ENODEV;
>  }
>=20
>=20
> ---------------------------------------------------------------------=
-
> Jestes kierowca? To poczytaj! >>> http://link.interia.pl/f199e
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
