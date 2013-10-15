From: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
Subject: Re: [PATCH v4] diff.c: keep arrow(=>) on show_stats()'s shortened filename part to make rename visible.
Date: Tue, 15 Oct 2013 13:24:49 +0300
Message-ID: <FC0E6C0F-0FF4-4D10-AC2B-B4DD9AC017A2@gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com> <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com> <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com> <AFC93704-D6C5-49AF-9A66-C5EA81348FFA@gmail.com> <CAMP44s0mkcocVCekrgYnnwcS9op2KBu69JQ2kDrmT48a3HBp6A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Felipe Contreras <felipe.contreras@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 15 12:25:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW1oB-00038l-FF
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 12:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758289Ab3JOKYz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Oct 2013 06:24:55 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65160 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758224Ab3JOKYz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Oct 2013 06:24:55 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so6593970lbh.19
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date
         :content-transfer-encoding:message-id:references:to;
        bh=jQQyIRtlvcaadmN6UBpXZeaZ9j55716GHHgBGCv0pZE=;
        b=qpI+TkdWOLUpImUCnrzsndLwu4fkCMCNu06WQrZNCsYN8q6dLQFciW8fGw3e/j8DFF
         5Ptt+OjU5Ky1jY7lV1cynOaHQCHiLAS7QpIsBvWUgBx/xpJ/L0qQPsvRBM8lBwi9vXyX
         HTysqf2Xbrtpprwlp+3BBIlDrF+aFjgbt3Iu7BDSw2eOloO+EIsMgWQ+3EFvsETyfI3C
         RdsHvOzBO+Vj0gB8VrWGkRjcyYs1hxLXiOlDOzJr/OAmgmrxFohLRqYfWOnvzlrwt3nI
         CI8ECG5Y6EtsHLWQ0blxFTXHgx8y5j/lYSbiijP6TBhNvd40/3vy7h604jKsKuTEUe36
         AVDw==
X-Received: by 10.112.52.225 with SMTP id w1mr6198839lbo.31.1381832693681;
        Tue, 15 Oct 2013 03:24:53 -0700 (PDT)
Received: from [10.128.134.109] (fsgw.f-secure.com. [193.110.108.33])
        by mx.google.com with ESMTPSA id ua4sm46970957lbb.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 03:24:53 -0700 (PDT)
In-Reply-To: <CAMP44s0mkcocVCekrgYnnwcS9op2KBu69JQ2kDrmT48a3HBp6A@mail.gmail.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236174>

Hello Felipe

Thank you for pointing out the style issue again.
I just fixed it and posted as [PATCH v5].

Thanks!

---
Tsuneo Yoshioka (=E5=90=89=E5=B2=A1 =E6=81=92=E5=A4=AB)
yoshiokatsuneo@gmail.com




On Oct 15, 2013, at 1:07 PM, Felipe Contreras <felipe.contreras@gmail.c=
om> wrote:

> On Tue, Oct 15, 2013 at 4:45 AM, Yoshioka Tsuneo
> <yoshiokatsuneo@gmail.com> wrote:
>>=20
>> "git diff -M --stat" can detect rename and show renamed file name li=
ke
>> "foofoofoo =3D> barbarbar". But if destination filename is long, the=
 line
>> is shortened like "...barbarbar" so there is no way to know whether =
the
>> file is renamed or existed in the source commit.
>> Make sure there is always an arrow, like "...foo =3D> ...bar".
>> The output can contains curly braces('{','}') for grouping.
>> So, in general, the outpu format is "<pfx>{<mid_a> =3D> <mid_b>}<sfx=
>"
>> To keep arrow("=3D>"), try to omit <pfx> as long as possible at firs=
t
>> because later part or changing part will be the more important part.
>> If it is not enough, shorten <mid_a>, <mid_b>, and <sfx> trying to
>> have the maximum length the same because those will be equaly import=
ant.
>=20
> This has similar style issues as v1.
>=20
>> -static char *pprint_rename(const char *a, const char *b)
>> +static void pprint_rename_find_common_prefix_suffix(const char *a, =
const char *b, struct strbuf *pfx, struct strbuf *a_mid, struct strbuf =
*b_mid, struct strbuf *sfx)
>> {
>>        const char *old =3D a;
>>        const char *new =3D b;
>> -       struct strbuf name =3D STRBUF_INIT;
>>        int pfx_length, sfx_length;
>>        int pfx_adjust_for_slash;
>>        int len_a =3D strlen(a);
>> @@ -1272,10 +1271,9 @@ static char *pprint_rename(const char *a, con=
st char *b)
>>        int qlen_b =3D quote_c_style(b, NULL, NULL, 0);
>>=20
>>        if (qlen_a || qlen_b) {
>> -               quote_c_style(a, &name, NULL, 0);
>> -               strbuf_addstr(&name, " =3D> ");
>> -               quote_c_style(b, &name, NULL, 0);
>> -               return strbuf_detach(&name, NULL);
>> +               quote_c_style(a, a_mid, NULL, 0);
>> +               quote_c_style(b, b_mid, NULL, 0);
>> +               return;
>>        }
>>=20
>>        /* Find common prefix */
>> @@ -1321,18 +1319,149 @@ static char *pprint_rename(const char *a, c=
onst char *b)
>>                a_midlen =3D 0;
>>        if (b_midlen < 0)
>>                b_midlen =3D 0;
>> +
>> +       strbuf_add(pfx, a, pfx_length);
>> +       strbuf_add(a_mid, a + pfx_length, a_midlen);
>> +       strbuf_add(b_mid, b + pfx_length, b_midlen);
>> +       strbuf_add(sfx, a + len_a - sfx_length, sfx_length);
>> +}
>>=20
>> -       strbuf_grow(&name, pfx_length + a_midlen + b_midlen + sfx_le=
ngth + 7);
>> -       if (pfx_length + sfx_length) {
>> -               strbuf_add(&name, a, pfx_length);
>> +/*
>> + * Omit each parts to fix in name_width.
>> + * Formatted string is "<pfx>{<a_mid> =3D> <b_mid>}<sfx>".
>> + * At first, omit <pfx> as long as possible.
>> + * If it is not enough, omit <a_mid>, <b_mid>, <sfx> by tring to se=
t the length of
>> + * those 3 parts(including "...") to the same.
>> + * Ex:
>> + * "foofoofoo =3D> barbarbar"
>> + *   will be like
>> + * "...foo =3D> ...bar".
>> + * "long_parent{foofoofoo =3D> barbarbar}longfilename"
>> + *   will be like
>> + * "...parent{...foofoo =3D> ...barbar}...lename"
>> + */
>> +static void pprint_rename_omit(struct strbuf *pfx, struct strbuf *a=
_mid, struct strbuf *b_mid, struct strbuf *sfx, int name_width)
>=20
> Seems like this line needs to be broken.
>=20
>> +{
>> +
>> +#define ARROW " =3D> "
>> +#define ELLIPSIS "..."
>> +#define swap(a,b) myswap((a),(b),sizeof(a))
>=20
> I'm not entirely sure, but I think this should be:
>=20
> #define swap(a, b) myswap((a), (b), sizeof(a))
>=20
>> +
>> +#define myswap(a, b, size) do {                \
>> +unsigned char mytmp[size];     \
>> +memcpy(mytmp, &a, size);               \
>> +memcpy(&a, &b, size);          \
>> +memcpy(&b, mytmp, size);               \
>> +} while (0)
>> +
>> +       int use_curly_braces =3D (pfx->len > 0) || (sfx->len > 0);
>> +       size_t name_len;
>> +       size_t len;
>> +       size_t part_lengths[4];
>> +       size_t max_part_len =3D 0;
>> +       size_t remainder_part_len =3D 0;
>> +       int i, j;
>> +
>> +       name_len =3D pfx->len + a_mid->len + b_mid->len + sfx->len +=
 strlen(ARROW) + (use_curly_braces?2:0);
>> +
>> +       if (name_len <=3D name_width){
>=20
> if () {
>=20
>> +               /* Everthing fits in name_width */
>> +               return;
>> +       }
>> +
>> +       if(use_curly_braces){
>=20
> Ditto.
>=20
>> +               if(strlen(ELLIPSIS) + (name_len - pfx->len) <=3D nam=
e_width){
>=20
> Ditto.
>=20
>> +                       /*
>> +                        Just omitting left of '{' is enough
>> +                        Ex: ...aaa{foofoofoo =3D> bar}file
>> +                        */
>> +                       strbuf_splice(pfx, name_len - pfx->len, name=
_width - (name_len - pfx->len), ELLIPSIS, strlen(ELLIPSIS));
>> +                       return;
>> +               }else{
>=20
> } else {
>=20
>> +                       if (pfx->len > strlen(ELLIPSIS)) {
>> +                               /*
>> +                                Just omitting left of '{' is not en=
ough
>> +                                name will be "...{SOMETHING}SOMETHI=
NG"
>> +                                */
>> +                               strbuf_reset(pfx);
>> +                               strbuf_addstr(pfx, ELLIPSIS);
>> +                       }
>> +               }
>> +       }
>> +
>> +       /* available length for a_mid, b_mid and sfx */
>> +       len =3D name_width - strlen(ARROW) - (use_curly_braces?2:0);
>=20
> use_curly_braces ? 2 : 0
>=20
>> +
>> +       /* a_mid, b_mid, sfx will be have the same max, including el=
lipsis("..."). */
>> +       part_lengths[0] =3D (int)a_mid->len;
>> +       part_lengths[1] =3D (int)b_mid->len;
>> +       part_lengths[2] =3D (int)sfx->len;
>> +
>> +       /* bubble sort of part_lengths, descending order */
>> +       for(i=3D0;i<3;i++){
>=20
> for (i =3D 0; i < 3; i++) {
>=20
>> +               for(j=3D i+1; j<3; j++){
>=20
> Ditto.
>=20
>> +                       if(part_lengths[j] > part_lengths[i]){
>=20
> if ()
>  foo;
>=20
> (it's a single line, no need for braces, In fact all the fors could
> get rid of them, but not really required.)
>=20
>> +                               swap(part_lengths[i], part_lengths[j=
]);
>> +                       }
>> +               }
>> +       }
>> +
>> +       if (part_lengths[1] + part_lengths[1] + part_lengths[2] <=3D=
 len) {
>> +               /*
>> +                * "{...foofoo =3D> barbar}file"
>> +                * There is only one omitting part.
>> +                */
>> +               max_part_len =3D len - part_lengths[1] - part_length=
s[2];
>> +       } else if (part_lengths[2] + part_lengths[2] + part_lengths[=
2] <=3D len){
>=20
> } else if () {
>=20
>> +               /*
>> +                * "{...foofoo =3D> ...barbar}file"
>> +                * There are 2 omitting part.
>> +                */
>> +               max_part_len =3D (len - part_lengths[2])/2;
>=20
> (len - part_lengths[2]) / 2
>=20
>> +               remainder_part_len =3D (len - part_lengths[2]) - max=
_part_len * 2;
>> +       } else {
>> +               /*
>> +                * "{...ofoo =3D> ...rbar}...file"
>> +                * There are 3 omitting part.
>> +                */
>> +               max_part_len =3D len / 3;
>> +               remainder_part_len =3D len - (max_part_len) * 3;
>> +       }
>> +
>> +       if (max_part_len < strlen(ELLIPSIS))
>> +               max_part_len =3D strlen(ELLIPSIS);
>> +
>> +       if (sfx->len > max_part_len)
>> +               strbuf_splice(sfx, 0, sfx->len - max_part_len + strl=
en(ELLIPSIS), ELLIPSIS, strlen(ELLIPSIS));
>> +       if (remainder_part_len=3D=3D2)
>=20
> remainder_part_len =3D=3D 2
>=20
>> +               max_part_len++;
>> +       if (a_mid->len > max_part_len)
>> +               strbuf_splice(a_mid, 0, a_mid->len - max_part_len + =
strlen(ELLIPSIS), ELLIPSIS, strlen(ELLIPSIS));
>> +       if (remainder_part_len=3D=3D1)
>=20
> Ditto.
>=20
>> +               max_part_len++;
>> +       if (b_mid->len > max_part_len)
>> +               strbuf_splice(b_mid, 0, b_mid->len - max_part_len + =
strlen(ELLIPSIS), ELLIPSIS, strlen(ELLIPSIS));
>> +}
>> +
>> +static char *pprint_rename(const char *a, const char *b, int name_w=
idth)
>> +{
>> +       struct strbuf pfx =3D STRBUF_INIT, a_mid =3D STRBUF_INIT, b_=
mid =3D STRBUF_INIT, sfx =3D STRBUF_INIT;
>> +       struct strbuf name =3D STRBUF_INIT;
>> +
>> +       pprint_rename_find_common_prefix_suffix(a, b, &pfx, &a_mid, =
&b_mid, &sfx);
>> +       pprint_rename_omit(&pfx, &a_mid, &b_mid, &sfx, name_width);
>> +
>> +       strbuf_grow(&name, pfx.len + a_mid.len + b_mid.len + sfx.len=
 + 7);
>=20
>> +       if (pfx.len + sfx.len) {
>> +               strbuf_addbuf(&name, &pfx);
>>                strbuf_addch(&name, '{');
>>        }
>> -       strbuf_add(&name, a + pfx_length, a_midlen);
>> +       strbuf_addbuf(&name, &a_mid);
>>        strbuf_addstr(&name, " =3D> ");
>> -       strbuf_add(&name, b + pfx_length, b_midlen);
>> -       if (pfx_length + sfx_length) {
>> +       strbuf_addbuf(&name, &b_mid);
>> +       if (pfx.len + sfx.len) {
>>                strbuf_addch(&name, '}');
>> -               strbuf_add(&name, a + len_a - sfx_length, sfx_length=
);
>> +               strbuf_addbuf(&name, &sfx);
>>        }
>>        return strbuf_detach(&name, NULL);
>> }
>> @@ -1418,23 +1547,31 @@ static void show_graph(FILE *file, char ch, =
int cnt, const char *set, const char
>>        fprintf(file, "%s", reset);
>> }
>>=20
>> -static void fill_print_name(struct diffstat_file *file)
>> +static void fill_print_name(struct diffstat_file *file, int name_wi=
dth)
>> {
>>        char *pname;
>>=20
>> -       if (file->print_name)
>> -               return;
>> -
>>        if (!file->is_renamed) {
>>                struct strbuf buf =3D STRBUF_INIT;
>> +               if (file->print_name)
>> +                       return;
>>                if (quote_c_style(file->name, &buf, NULL, 0)) {
>>                        pname =3D strbuf_detach(&buf, NULL);
>>                } else {
>>                        pname =3D file->name;
>>                        strbuf_release(&buf);
>>                }
>> +               if(strlen(pname) > name_width){
>=20
> if () {
>=20
>> +                       struct strbuf buf2 =3D STRBUF_INIT;
>> +                       strbuf_addstr(&buf2, "...");
>> +                       strbuf_addstr(&buf2, pname + strlen(pname) -=
 name_width - 3);
>> +               }
>>        } else {
>> -               pname =3D pprint_rename(file->from_name, file->name)=
;
>> +               if (file->print_name){
>=20
> Ditto
>=20
>> +                       free(file->print_name);
>> +                       file->print_name =3D NULL;
>> +               }
>> +               pname =3D pprint_rename(file->from_name, file->name,=
 name_width);
>>        }
>>        file->print_name =3D pname;
>> }
>> @@ -1517,7 +1654,7 @@ static void show_stats(struct diffstat_t *data=
, struct diff_options *options)
>>                        count++; /* not shown =3D=3D room for one mor=
e */
>>                        continue;
>>                }
>> -               fill_print_name(file);
>> +               fill_print_name(file, INT_MAX);
>>                len =3D strlen(file->print_name);
>>                if (max_len < len)
>>                        max_len =3D len;
>> @@ -1629,7 +1766,7 @@ static void show_stats(struct diffstat_t *data=
, struct diff_options *options)
>>        for (i =3D 0; i < count; i++) {
>>                const char *prefix =3D "";
>>                struct diffstat_file *file =3D data->files[i];
>> -               char *name =3D file->print_name;
>> +               char *name;
>>                uintmax_t added =3D file->added;
>>                uintmax_t deleted =3D file->deleted;
>>                int name_len;
>> @@ -1637,6 +1774,8 @@ static void show_stats(struct diffstat_t *data=
, struct diff_options *options)
>>                if (!file->is_interesting && (added + deleted =3D=3D =
0))
>>                        continue;
>>=20
>> +               fill_print_name(file, name_width);
>> +               name =3D file->print_name;
>>                /*
>>                 * "scale" the filename
>>                 */
>> @@ -1772,7 +1911,7 @@ static void show_numstat(struct diffstat_t *da=
ta, struct diff_options *options)
>>                                "%"PRIuMAX"\t%"PRIuMAX"\t",
>>                                file->added, file->deleted);
>>                if (options->line_termination) {
>> -                       fill_print_name(file);
>> +                       fill_print_name(file, INT_MAX);
>>                        if (!file->is_renamed)
>>                                write_name_quoted(file->name, options=
->file,
>>                                                  options->line_termi=
nation);
>> @@ -4258,7 +4397,7 @@ static void show_mode_change(FILE *file, struc=
t diff_filepair *p, int show_name,
>> static void show_rename_copy(FILE *file, const char *renamecopy, str=
uct diff_filepair *p,
>>                        const char *line_prefix)
>> {
>> -       char *names =3D pprint_rename(p->one->path, p->two->path);
>> +       char *names =3D pprint_rename(p->one->path, p->two->path, IN=
T_MAX);
>>=20
>>        fprintf(file, " %s %s (%d%%)\n", renamecopy, names, similarit=
y_index(p));
>>        free(names);
>> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
>> index 2f327b7..03d6371 100755
>> --- a/t/t4001-diff-rename.sh
>> +++ b/t/t4001-diff-rename.sh
>> @@ -156,4 +156,16 @@ test_expect_success 'rename pretty print common=
 prefix and suffix overlap' '
>>        test_i18ngrep " d/f/{ =3D> f}/e " output
>> '
>>=20
>> +test_expect_success 'rename of very long path shows =3D>' '
>> +       mkdir long_dirname_that_does_not_fit_in_a_single_line &&
>> +       mkdir another_extremely_long_path_but_not_the_same_as_the_fi=
rst &&
>> +       cp path1 long_dirname*/ &&
>> +       git add long_dirname*/path1 &&
>> +       test_commit add_long_pathname &&
>> +       git mv long_dirname*/path1 another_extremely_*/ &&
>> +       test_commit move_long_pathname &&
>> +       git diff -M --stat HEAD^ HEAD >output &&
>> +       test_i18ngrep "=3D>.*path1" output
>> +'
>> +
>> test_done
>=20
> --=20
> Felipe Contreras
